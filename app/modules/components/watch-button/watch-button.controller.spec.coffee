describe "WatchButton", ->
    $controller = null
    $rootScope = null
    mocks = {}

    _mocks = ->
        mocks = {
            onWatch: sinon.stub(),
            onUnwatch: sinon.stub()
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

    it "watch", ->
        $scope = $rootScope.$new()

        ctrl = $controller("WatchButton", $scope, {
            item: {is_watchd: false}
            onWatch: mocks.onWatch
            onUnwatch: mocks.onUnwatch
        })

        mocks.onWatch.withArgs().promise().resolve()

        ctrl.toggleWatch()

        expect(mocks.onWatch).to.be.calledOnce

    it "unwatch", ->
        $scope = $rootScope.$new()

        ctrl = $controller("WatchButton", $scope, {
            item: {is_watchd: true}
            onWatch: mocks.onWatch
            onUnwatch: mocks.onUnwatch
        })

        mocks.onUnwatch.withArgs().promise().resolve()

        ctrl.toggleWatch()

        expect(mocks.onUnwatch).to.be.calledOnce
