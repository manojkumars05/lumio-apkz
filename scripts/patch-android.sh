#!/bin/bash
# Runs after `npx cap add android`: adds file-download support to the app WebView.
set -e
MAN=android/app/src/main/AndroidManifest.xml
DIR=android/app/src/main/java/com/lumio/app
sed -i 's#<application#<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" android:maxSdkVersion="28"/>\n    <application#' "$MAN"
mkdir -p "$DIR"
cat > "$DIR/MainActivity.java" <<'JAVA'
package com.lumio.app;

import android.app.DownloadManager;
import android.content.Context;
import android.net.Uri;
import android.os.Bundle;
import android.os.Environment;
import android.webkit.CookieManager;
import android.webkit.URLUtil;
import android.widget.Toast;
import com.getcapacitor.BridgeActivity;

public class MainActivity extends BridgeActivity {
  @Override
  public void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    // always load fresh website files on app start (no stale CSS/JS)
    getBridge().getWebView().clearCache(true);
    getBridge().getWebView().setDownloadListener((url, userAgent, contentDisposition, mimeType, length) -> {
      try {
        String name = URLUtil.guessFileName(url, contentDisposition, mimeType);
        DownloadManager.Request r = new DownloadManager.Request(Uri.parse(url));
        r.setMimeType(mimeType);
        r.addRequestHeader("cookie", CookieManager.getInstance().getCookie(url));
        r.addRequestHeader("User-Agent", userAgent);
        r.setNotificationVisibility(DownloadManager.Request.VISIBILITY_VISIBLE_NOTIFY_COMPLETED);
        r.setDestinationInExternalPublicDir(Environment.DIRECTORY_DOWNLOADS, name);
        ((DownloadManager) getSystemService(Context.DOWNLOAD_SERVICE)).enqueue(r);
        Toast.makeText(this, "Downloading " + name, Toast.LENGTH_SHORT).show();
      } catch (Exception e) {
        Toast.makeText(this, "Download failed", Toast.LENGTH_SHORT).show();
      }
    });
  }
}
JAVA
