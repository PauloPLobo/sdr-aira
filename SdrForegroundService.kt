
package com.aira.sdr

import android.app.*
import android.content.Intent
import android.os.IBinder
import androidx.core.app.NotificationCompat

class SdrForegroundService : Service() {
    private val CHANNEL_ID = "AIRA_SDR_CHANNEL"
    override fun onCreate() { super.onCreate(); createChannel() }
    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        val openIntent = Intent(this, MainActivity::class.java)
        val pendingIntent = PendingIntent.getActivity(this, 0, openIntent, PendingIntent.FLAG_IMMUTABLE)
        val notification = NotificationCompat.Builder(this, CHANNEL_ID)
            .setContentTitle("AIRA SDR ativo")
            .setContentText("A tocar mesmo com ecra desligado")
            .setSmallIcon(android.R.drawable.ic_media_play)
            .setContentIntent(pendingIntent)
            .setOngoing(true)
            .build()
        startForeground(1, notification)
        return START_STICKY
    }
    private fun createChannel() {
        val channel = NotificationChannel(CHANNEL_ID, "AIRA SDR", NotificationManager.IMPORTANCE_LOW)
        val nm = getSystemService(NotificationManager::class.java)
        nm.createNotificationChannel(channel)
    }
    override fun onBind(intent: Intent?): IBinder? = null
}
