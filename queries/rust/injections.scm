;extends
;html_templates
(
      (raw_string_literal) @html
      (#match? @html "*DOCTYPE.*")
      (#set! injection.language "html")
      ) @injection.content
