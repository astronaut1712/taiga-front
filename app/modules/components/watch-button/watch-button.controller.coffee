class WatchButtonController
    constructor: ->
        @.isMouseOver = false

    showTextWhenMouseIsOver: ->
        @.isMouseOver = true

    showTextWhenMouseIsLeave: ->
        @.isMouseOver = false

    toggleWatch: ->
        if not @.item.is_watched
            @._watch()
        else
            @._unwatch()

    _watch: ->
        @.onWatch().then =>
            @.showTextWhenMouseIsLeave()

    _unwatch: ->
        @.onUnwatch()

angular.module("taigaComponents").controller("WatchButton", WatchButtonController)
