describe "VoteButton", ->
    $controller = null
    $rootScope = null
    mocks = {}

    _mocks = ->
        mocks = {
            onUpvote: sinon.stub(),
            onDownvote: sinon.stub()
        }

    _inject = (callback) ->
        inject (_$controller_, _$rootScope_) ->
            $rootScope = _$rootScope_
            $controller = _$controller_

    _setup = ->
        _mocks()
        _inject()

    beforeEach ->
        module "taigaComponents"
        _setup()

    it "upvote", ->
        $scope = $rootScope.$new()

        ctrl = $controller("VoteButton", $scope, {
            item: {is_voted: false}
            onUpvote: mocks.onUpvote
            onDownvote: mocks.onDownvote
        })

        mocks.onUpvote.withArgs().promise().resolve()

        ctrl.toggleVote()

        expect(mocks.onUpvote).to.be.calledOnce

    it "downvote", ->
        $scope = $rootScope.$new()

        ctrl = $controller("VoteButton", $scope, {
            item: {is_voted: true}
            onUpvote: mocks.onUpvote
            onDownvote: mocks.onDownvote
        })

        mocks.onDownvote.withArgs().promise().resolve()

        ctrl.toggleVote()

        expect(mocks.onDownvote).to.be.calledOnce
