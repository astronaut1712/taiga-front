describe "LikeProjectButton", ->
    $provide = null
    $controller = null
    mocks = {}

    _mockTgConfirm = ->
        mocks.tgConfirm = {
            notify: sinon.stub()
        }

        $provide.value("$tgConfirm", mocks.tgConfirm)

    _mockTgLikeProjectButton = ->
        mocks.tgLikeProjectButton = {
            like: sinon.stub(),
            unlike: sinon.stub()
        }

        $provide.value("tgLikeProjectButtonService", mocks.tgLikeProjectButton)

    _mocks = ->
        module (_$provide_) ->
            $provide = _$provide_

            _mockTgConfirm()
            _mockTgLikeProjectButton()

            return null

    _inject = ->
        inject (_$controller_) ->
            $controller = _$controller_

    _setup = ->
        _mocks()
        _inject()

    beforeEach ->
        module "taigaProjects"

        _setup()

    it "toggleLike false -> true", () ->
        project = Immutable.fromJS({
            id: 3,
            is_fan: false
        })

        ctrl = $controller("LikeProjectButton")
        ctrl.project = project

        mocks.tgLikeProjectButton.like.withArgs(project.get('id')).promise().resolve()

        ctrl.toggleLike()

        expect(mocks.tgLikeProjectButton.like).to.be.calledOnce

    it "toggleLike false -> true, notify error", (done) ->
        project = Immutable.fromJS({
            id: 3,
            is_fan: false
        })

        ctrl = $controller("LikeProjectButton")
        ctrl.project = project

        mocks.tgLikeProjectButton.like.withArgs(project.get('id')).promise().reject()

        ctrl.toggleLike().finally () ->
            expect(mocks.tgConfirm.notify.withArgs("error")).to.be.calledOnce
            done()

    it "toggleLike true -> false", () ->
        project = Immutable.fromJS({
            is_fan: true
        })

        ctrl = $controller("LikeProjectButton")
        ctrl.project = project

        mocks.tgLikeProjectButton.unlike.withArgs(project.get('id')).promise().resolve()

        ctrl.toggleLike()

        expect(mocks.tgLikeProjectButton.unlike).to.be.calledOnce

    it "toggleLike true -> false, notify error", (done) ->
        project = Immutable.fromJS({
            is_fan: true
        })

        ctrl = $controller("LikeProjectButton")
        ctrl.project = project

        mocks.tgLikeProjectButton.unlike.withArgs(project.get('id')).promise().reject()

        ctrl.toggleLike().finally () ->
            expect(mocks.tgConfirm.notify.withArgs("error")).to.be.calledOnce
            done()
