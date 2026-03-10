import com.android.build.gradle.LibraryExtension

allprojects {
repositories {
google()
mavenCentral()
}
}

val newBuildDir = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
val newSubprojectBuildDir = newBuildDir.dir(project.name)
project.layout.buildDirectory.value(newSubprojectBuildDir)
}

subprojects {
project.evaluationDependsOn(":app")
}

/*
FIX: Namespace error for plugins like call_log
*/
subprojects {
afterEvaluate {
if (plugins.hasPlugin("com.android.library")) {
extensions.findByName("android")?.let { ext ->
val androidExt = ext as LibraryExtension
if (androidExt.namespace == null) {
androidExt.namespace = "com.autofix.${project.name}"
}
}
}
}
}

tasks.register<Delete>("clean") {
delete(rootProject.layout.buildDirectory)
}
