function page(
    info::Dict{AbstractString, AbstractString},
    content::OrderedDict{AbstractString, Any},
    page::AbstractString,
    opt_in::Bool
    )
    str =
    """
    <!doctype html>
    <!-- This code was generated using the StaticWebPages.jl site generator that is under the GPLv2 license. More info at https://github.com/Azzaare/StaticWebPages.jl -->
    <html class="no-js" lang="$(info["lang"])">
    $(head(info, page))

    <body>
        <div class="title-bar" data-responsive-toggle="offCanvas" data-hide-for="medium">
            <button class="menu-icon" type="button" data-toggle="offCanvas"></button>
            <div class="title-bar-title">Menu</div>
        </div>
        <div class="off-canvas position-left reveal-for-medium" id="offCanvas" data-off-canvas>
            $(nav(info, content, page, opt_in))
        </div>

        <div class="off-canvas-content" data-off-canvas-content>
    """

    x = 2 # <hx> title level
    odd = true

    for section in content[page]
        centered = x==2 ? "" : " centered"
        oddness = odd ? "content-odd" : "content-even"
        str *=
        """
        <div class="grid-x grid-margin-x content $centered $oddness">
            $(to_html(section, x))
        </div>
        """
        if x == 2
            x += 1
        end
        odd = !odd
    end

    str *=
    """
        </div>

        $(js())
    </body>
    </html>
    """
    return str
end
