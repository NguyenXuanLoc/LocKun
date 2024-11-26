package lockun.vn.app

import android.content.Intent
import android.net.Uri
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.embedding.android.FlutterFragmentActivity




class MainActivity : FlutterFragmentActivity() {
    private val CHANNEL = "plugins.flutter.io/navigator"
    private val OPEN_MAP = "openMap"
    private val OPEN_INSTAGAGRAM = "openInstagram"
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->
            if (call.method == OPEN_MAP) {
                val deepLinkUrl =
                    Uri.parse(call.arguments.toString())
                val intent = Intent(Intent.ACTION_VIEW, deepLinkUrl)
                intent.setPackage("com.google.android.apps.maps")
                if (intent.resolveActivity(packageManager) != null) {
                    startActivity(intent)
                    result.success(true)
                } else result.success(false)
            }
            if (call.method == OPEN_INSTAGAGRAM) {
                val deepLinkUrl =
                    Uri.parse("instagram://user?username=" + call.arguments)
                val intent = Intent(Intent.ACTION_VIEW, deepLinkUrl)
                intent.setPackage("com.instagram.android")
                if (intent.resolveActivity(packageManager) != null) {
                    startActivity(intent)
                    result.success(true)
                } else result.success(false)
            }
        }
    }
}

