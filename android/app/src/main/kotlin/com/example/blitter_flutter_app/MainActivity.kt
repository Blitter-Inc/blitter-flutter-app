package com.example.blitter_flutter_app

import android.app.Activity
import android.net.Uri
import android.util.Log
import android.content.Intent

import androidx.annotation.NonNull;

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {
  
  lateinit var callResult: MethodChannel.Result

  override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
    GeneratedPluginRegistrant.registerWith(flutterEngine)


    MethodChannel(flutterEngine.dartExecutor, "upi").setMethodCallHandler { call, result ->
      if (call.method == "pay") {
        val name = call.argument("name") as String?
        val vpa = call.argument("vpa") as String?
        val amount = call.argument("amount") as String?
        val currency = call.argument("currency") as String?
        val uri = Uri.parse("upi://pay").buildUpon()
                .appendQueryParameter("pa", vpa)
                .appendQueryParameter("pn", name)
                .appendQueryParameter("tn", "Bill payment via Blitter")
                .appendQueryParameter("am", amount)
                .appendQueryParameter("cu", currency)
                .build()

        val upiPayIntent = Intent(Intent.ACTION_VIEW)
        upiPayIntent.data = uri

        // will always show a dialog to user to choose an app
        val chooser = Intent.createChooser(upiPayIntent, "Pay with")

        if (null != chooser.resolveActivity(packageManager)) {
            startActivityForResult(chooser, 1)
            this.callResult = result
        } else {
          result.error("ERROR", "No UPI app found, please install one to continue", null)
        }
      }
    }
  }

  override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
    super.onActivityResult(requestCode, resultCode, data)
    when (requestCode) {
      1 -> if (Activity.RESULT_OK == resultCode || resultCode == 11) {
          if (data != null) {
              val trxt = data.getStringExtra("response") as String
              Log.d("UPI", "onActivityResult: $trxt")
              if (trxt.contains("txnId")) {
                this.callResult.success("success")
              } else {
                this.callResult.error("ERROR", "Error performing transaction", null)
              }
          } else {
              Log.d("UPI", "onActivityResult: " + "Return data is null")
              this.callResult.error("ERROR", "Transaction was not performed.", null)
          }
      } else {
          Log.d("UPI", "onActivityResult: " + "UPI app backed")
          this.callResult.error("ERROR", "Transaction was not performed.", null)
      }
    }
  }
}
