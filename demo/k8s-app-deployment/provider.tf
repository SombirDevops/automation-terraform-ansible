provider "google" {
 credentials = file("CREDENTIAL_JSON_FILE")
 project     = "PROJECT_ID"
 region      = "REGION"
}
