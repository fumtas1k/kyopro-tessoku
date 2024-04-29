plugins {
  kotlin("jvm") version "1.8.10"
}

group = "org.example"
version = "1.0-SNAPSHOT"

repositories {
  mavenCentral()
}

dependencies {
  testImplementation("org.junit.jupiter:junit-jupiter:5.8.2")
  implementation("org.jetbrains.kotlin:kotlin-reflect:1.8.10")
}

tasks.test {
  useJUnitPlatform()
}

kotlin {
  jvmToolchain(11)
}

tasks.withType<Jar> { duplicatesStrategy = DuplicatesStrategy.INCLUDE }
