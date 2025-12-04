provider "google" {
  project = "honorato-devops-iac"
  region  = "us-central01"
  zone    = "us-central01-c"
  credentials = "${file("serviceaccount.yaml")}"
}

resource "google_folder" "Financeiro" {
  display_name = "Financeiro"
  parent       = "organizations/630729645030"
}

resource "google_folder" "SalesForce" {
  display_name = "SalesForce"
  parent       = google_folder.Financeiro.name
}

resource "google_folder" "Desenvolvimento" {
  display_name = "Desenvolvimento"
  parent       = google_folder.SalesForce.name
}

resource "google_folder" "Producao" {
  display_name = "Producao"
  parent       = google_folder.SalesForce.name
}


resource "google_project" "honorato02-salesforce-dev" {
  name       = "SalesForce-Dev"
  project_id = "honorato02-salesforce-dev"
  folder_id  = google_folder.Desenvolvimento.name
  auto_create_network=false
  billing_account = "028973-A8340F-83D8E5"

}

# resource "google_project" "honorato-salesforce-prod" {
#   name       = "SalesForce-Prod"
#   project_id = "honorato-salesforce-prod"
#   folder_id  = google_folder.Producao.name
#   auto_create_network=false
#   billing_account = "03B2C4-70459E-F53446"
# }