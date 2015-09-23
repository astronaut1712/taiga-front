class LikeButtonController
    @.$inject = [
        "$tgConfirm"
        "tgLikeButtonService"
    ]

    constructor: (@confirm, @likeButtonService)->
        @.isMouseOver = false
        @._changeOnMouseOver = true

    showTextWhenMouseIsOver: ->
        @.isMouseOver = true if @._changeOnMouseOver

    showTextWhenMouseIsOut: ->
        @.isMouseOver = false
        @._changeOnMouseOver = true

    toggleLike: ->
        if not @.project.get("is_liked")
            @._like()
        else
            @._unlike()

        @.isMouseOver = false
        @._changeOnMouseOver = false

    _like: ->
        return @likeButtonService.like(@.project.get('id')).catch () =>
            @confirm.notify("error")

    _unlike: ->
        return @likeButtonService.unlike(@.project.get('id')).catch () =>
            @confirm.notify("error")

angular.module("taigaComponents").controller("LikeButton", LikeButtonController)
