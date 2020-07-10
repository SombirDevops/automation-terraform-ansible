provider "google" {
 credentials = file("/opt/credential_demo.json")
 project     = "evident-syntax-282809"
 region      = "us-west1"
}
