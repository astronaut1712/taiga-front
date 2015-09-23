class LikeButtonController
    @.$inject = [
        "$tgConfirm"
        "tgLikeButtonService"
    ]

    constructor: (@confirm, @likeButtonService)->
        @.like = true
        @._allowMouseOverText()

    _allowMouseOverText: ->
        @._changeOnMouseOver = true

    _disallowMouseOverText: ->
        @._changeOnMouseOver = false

    showTextWhenMouseIsOver: ->
        @.isMouseOver = true if @._changeOnMouseOver

    showTextWhenMouseIsOut: ->
        @.isMouseOver = false
        @._allowMouseOverText()

    toggleLike: ->
        if not @.project.get("is_liked")
            @._like()
        else
            @._unlike()

        @.showTextWhenMouseIsOut()

    _like: ->
        return @likeButtonService.like(@.project.get('id')).catch () =>
            @confirm.notify("error")

    _unlike: ->
        return @likeButtonService.unlike(@.project.get('id')).catch () =>
            @confirm.notify("error")

angular.module("taigaComponents").controller("LikeButton", LikeButtonController)
