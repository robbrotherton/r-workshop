if (!nzchar(Sys.getenv("QUARTO_PROJECT_RENDER_ALL"))) {
  quit()
} else {
  message("switching in pdf yml")
  file.copy(from = "_quarto_pdf.yml", to = "_quarto.yml", overwrite = TRUE)
  # file.rename(from = "_quarto.yml", to = "_quarto_website.yml")
  # file.rename("_quarto_pdf.yml", "_quarto.yml")
  # on.exit(file.copy(from = "_quarto_website.yml", "_quarto.yml", overwrite = TRUE), add = TRUE)
  message("rendering project as book pdf")
  quarto::quarto_render(as_job = FALSE)

  message("rendering done, switching the yml file back")
  file.copy(from = "_quarto_website.yml", "_quarto.yml", overwrite = TRUE)
}
