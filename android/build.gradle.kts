import org.gradle.api.JavaVersion
import org.jetbrains.kotlin.gradle.dsl.JvmTarget

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// 统一所有子项目的Java和Kotlin版本
subprojects {
    afterEvaluate {
        if (hasProperty("android")) {
            extensions.configure<com.android.build.gradle.BaseExtension>("android") {
                compileOptions {
                    sourceCompatibility = JavaVersion.VERSION_21
                    targetCompatibility = JavaVersion.VERSION_21
                }
            }
        }
        // 配置Kotlin编译任务的JVM目标版本
        tasks.withType<org.jetbrains.kotlin.gradle.tasks.KotlinCompile>().configureEach {
            compilerOptions {
                jvmTarget.set(JvmTarget.JVM_21)
            }
        }
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    // Only relocate build directory if the subproject is on the same drive as the root project
    // to avoid "different roots" error when plugins are in a different drive (e.g. C: vs D:)
    val rootDrive = rootProject.rootDir.absolutePath.split(File.separator)[0]
    val projectDrive = project.projectDir.absolutePath.split(File.separator)[0]

    if (rootDrive.equals(projectDrive, ignoreCase = true)) {
        val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
        project.layout.buildDirectory.value(newSubprojectBuildDir)
    }
}

subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
