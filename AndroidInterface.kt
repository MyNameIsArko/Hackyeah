package com.mycompany.mygame

import android.content.Context
import android.content.SharedPreferences
import org.godotengine.godot.Godot
import org.godotengine.godot.GodotLib
import org.godotengine.godot.plugin.GodotPlugin

class AndroidInterface(godot: Godot) : GodotPlugin(godot) {
    private val sharedPrefsName = "MyGamePrefs"

    init {
        instance = this
    }

    companion object {
        private lateinit var instance: AndroidInterface

        fun saveTime(time: String) {
            val prefs: SharedPreferences = instance.activity.getSharedPreferences(instance.sharedPrefsName, Context.MODE_PRIVATE)
            val editor = prefs.edit()
            editor.putString("saved_time", time)
            editor.apply()
        }

        fun loadTime(): String {
            val prefs: SharedPreferences = instance.activity.getSharedPreferences(instance.sharedPrefsName, Context.MODE_PRIVATE)
            return prefs.getString("saved_time", "") ?: ""
        }
    }

    override fun onMainDestroy() {
        // chuj
    }
}
