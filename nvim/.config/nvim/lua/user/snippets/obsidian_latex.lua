local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets("markdown", {
    -- Inline Math
    s("inline", {
        t("$"), i(1), t("$")
    }),
    -- Display Math
    s("display", {
        t("$$"), i(1), t("$$")
    }),

    s("frac", {
        t("\\frac{"), i(1), t("}{"), i(2), t("}")
    }),
    s("sum", {
        t("\\sum_{"), i(1, "i=1"), t("}^{"), i(2, "n"), t("} ")
    }),
    s("int", {
        t("\\int_{"), i(1, "a"), t("}^{"), i(2, "b"), t("} ")
    })
})

