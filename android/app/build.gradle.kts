import java.util.Properties
import java.io.FileInputStream

plugins {
id("com.android.application")
id("com.google.gms.google-services")
id("kotlin-android")
id("dev.flutter.flutter-gradle-plugin")
}

android {
namespace = "com.diin.call_monitor"
compileSdk = 36
ndkVersion = "29.0.14206865"

```
defaultConfig {
    applicationId = "com.diin.call_monitor"
    minSdk = 23
    targetSdk = 36
    versionCode = flutter.versionCode
    versionName = flutter.versionName
    multiDexEnabled = true

    ndk {
        abiFilters.clear()
        abiFilters += listOf("arm64-v8a")
    }
}

packaging {
    jniLibs {
        useLegacyPackaging = false
    }
    resources {
        excludes += setOf(
            "META-INF/AL2.0",
            "META-INF/LGPL2.1"
        )
    }
}

compileOptions {
    sourceCompatibility = JavaVersion.VERSION_11
    targetCompatibility = JavaVersion.VERSION_11
    isCoreLibraryDesugaringEnabled = true
}

kotlinOptions {
    jvmTarget = JavaVersion.VERSION_11.toString()
}

signingConfigs {

    create("release") {

        val keystorePropsFile = rootProject.file("key.properties")

        if (keystorePropsFile.exists()) {
            val props = Properties()
            props.load(FileInputStream(keystorePropsFile))

            storeFile = file(props["storeFile"] as String)
            storePassword = props["storePassword"] as String
            keyAlias = props["keyAlias"] as String
            keyPassword = props["keyPassword"] as String
        }
    }
}

buildTypes {

    getByName("release") {

        val keystorePropsFile = rootProject.file("key.properties")

        if (keystorePropsFile.exists()) {
            signingConfig = signingConfigs.getByName("release")
        } else {
            signingConfig = signingConfigs.getByName("debug")
        }

        isMinifyEnabled = true
        isShrinkResources = true

        proguardFiles(
            getDefaultProguardFile("proguard-android-optimize.txt"),
            "proguard-rules.pro"
        )
    }

    getByName("debug") {
        isMinifyEnabled = false
        isShrinkResources = false
    }
}

bundle {
    storeArchive { }
}
```

}

flutter {
source = "../.."
}

dependencies {
implementation("androidx.multidex:multidex:2.0.1")
coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.5")
}
