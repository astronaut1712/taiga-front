class VoteButtonController
    constructor: ->
        @.isMouseOver = false

    showTextWhenMouseIsOver: ->
        @.isMouseOver = true

    showTextWhenMouseIsLeave: ->
        @.isMouseOver = false

    toggleVote: ->
        if not @.item.is_voted
            @._upvote()
        else
            @._downvote()

    _upvote: ->
        @.onUpvote().then =>
            @.showTextWhenMouseIsLeave()

    _downvote: ->
        @.onDownvote()

angular.module("taigaComponents").controller("VoteButton", VoteButtonController)
