;pythoncode
        (element
          (start_tag
            (attribute
              (quoted_attribute_value
                ((attribute_value) @_idd (#eq? @_idd "python")))))
          ((text) @injection.content (#set! injection.language "python")))
      
;comment
((comment) @injection.content
(#set! injection.language "comment"))

;css
((style_element
(start_tag) @_no_type_lang
(raw_text) @injection.content)
(#not-lua-match? @_no_type_lang "%slang%s*=")
(#not-lua-match? @_no_type_lang "%stype%s*=")
(#set! injection.language "css"))

;javascript
((script_element
(start_tag) @_no_type_lang
(raw_text) @injection.content)
(#not-lua-match? @_no_type_lang "%slang%s*=")
(#not-lua-match? @_no_type_lang "%stype%s*=")
(#set! injection.language "javascript"))

;html_5
(script_element
(start_tag
(attribute
(attribute_name) @_attr
(#eq? @_attr "type")
(quoted_attribute_value
(attribute_value) @_type)))
(raw_text) @injection.content
(#set-lang-from-mimetype! @_type))

;css_2
((attribute
(attribute_name) @_attr
(quoted_attribute_value
(attribute_value) @injection.content))
(#eq? @_attr "style")
(#set! injection.language "css"))

;javascript_1
((attribute
(quoted_attribute_value
(attribute_value) @injection.content))
(#lua-match? @injection.content "%${")
(#offset! @injection.content 0 2 0 -1)
(#set! injection.language "javascript"))

;javascript_2
((attribute
(attribute_value) @injection.content)
(#lua-match? @injection.content "%${")
(#offset! @injection.content 0 2 0 -2)
(#set! injection.language "javascript"))

;regex
(element
(_
(tag_name) @_tagname
(#eq? @_tagname "input")
(attribute
(attribute_name) @_attr
[
(quoted_attribute_value
(attribute_value) @injection.content)
(attribute_value) @injection.content
]
(#eq? @_attr "pattern"))
(#set! injection.language "regex")))

;javascript_3
(attribute
(attribute_name) @_name
(#lua-match? @_name "^on[a-z]+$")
(quoted_attribute_value
(attribute_value) @injection.content)
(#set! injection.language "javascript"))

;python
(element
(start_tag
(tag_name) @_py_script)
(text) @injection.content
(#any-of? @_py_script "py-script" "py-repl")
(#set! injection.language "python"))

;python_1
(script_element
(start_tag
(attribute
(attribute_name) @_attr
(quoted_attribute_value
(attribute_value) @_type)))
(raw_text) @injection.content
(#eq? @_attr "type")
(#any-of? @_type "pyscript" "py-script")
(#set! injection.language "python"))

;toml
(element
(start_tag
(tag_name) @_py_config)
(text) @injection.content
(#eq? @_py_config "py-config")
(#set! injection.language "toml"))

