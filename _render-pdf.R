if (!nzchar(Sys.getenv("QUARTO_PROJECT_RENDER_ALL"))) {
  quit()
} else {
  file.rename(from = "_quarto.yml", to = "_quarto_website.yml")
  file.rename("_quarto_pdf.yml", "_quarto.yml")
  on.exit(file.rename("_quarto.yml", "_quarto_pdf.yml"))
  on.exit(file.rename("_quarto_website.yml", "_quarto.yml"), add = TRUE)
  quarto::quarto_render(..., as_job = FALSE)
}
