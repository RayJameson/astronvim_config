;extends
;all_sql

  (string 
    (string_content) @injection.content
      (#vim-match? @injection.content "^\w*SELECT|FROM|INNER JOIN|WHERE|CREATE|DROP|INSERT|UPDATE|ALTER.*$")
      (#set! injection.language "sql"))

;css_variables
        (assignment
            ((identifier) @_varx (#match? @_varx ".*css$"))
            (string
                (string_content) @injection.content (#set! injection.language "css"))) 
      
;html_variables
        (assignment
            ((identifier) @_varx (#match? @_varx ".*[hH][tT][mM][lL]$"))
            (string
                (string_content) @injection.content (#set! injection.language "html"))) 
      
;loads_attribute_json
        (call
          function: (attribute
              attribute: (identifier) @_idd (#eq? @_idd "loads"))
          arguments: (argument_list
            (string (string_content) @injection.content (#set! injection.language "json") ) ) )
      
;rst_for_docstring
      (function_definition
        (block
          (expression_statement
            (string
                (string_content) @injection.content (#set! injection.language "rst")))))
      
;sql_in_call
(call
  function: (attribute attribute: (identifier) @id (#match? @id "execute|read_sql"))
  arguments: (argument_list
     (string (string_content) @injection.content (#set! injection.language "sql"))))
     
;style_attribute_css
        (call
          function: (attribute
              attribute: (identifier) @_idd (#eq? @_idd "style"))
          arguments: (argument_list
            (string (string_content) @injection.content (#set! injection.language "css")))) 
      
