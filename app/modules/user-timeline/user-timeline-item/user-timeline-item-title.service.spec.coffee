describe "tgUserTimelineItemTitle", ->
    mySvc = null
    mockTranslate = null
    timeline = event = type = null

    _mockTranslate = () ->
        _provide (provide) ->
            mockTranslate = {
                instant: sinon.stub()
            }

            provide.value "$translate", mockTranslate

    _provide = (callback) ->
        module ($provide) ->
            callback($provide)
            return null

    _mocks = () ->
        _mockTranslate()

    _inject = ->
        inject (_tgUserTimelineItemTitle_) ->
            mySvc = _tgUserTimelineItemTitle_

    _setup = ->
        _mocks()
        _inject()

    beforeEach ->
        module "taigaUserTimeline"
        _setup()

    it "title with username", () ->
        timeline = Immutable.fromJS({
            data: {
                user: {
                    username: 'xx',
                    name: 'oo',
                    is_profile_visible: true
                }
            }
        })

        event = {}

        type = {
            key: 'TITLE_USER_NAME',
            translate_params: ['username']
        }

        mockTranslate.instant
            .withArgs('COMMON.SEE_USER_PROFILE', {username: timeline.getIn(['data', 'user', 'username'])})
            .returns('user-param')

        usernamelink = sinon.match ((value) ->
            return value.username == '<a tg-nav="user-profile:username=vm.timeline.getIn([\'data\', \'user\', \'username\'])" title="user-param">oo</a>'
         ), "usernamelink"

        mockTranslate.instant
            .withArgs('TITLE_USER_NAME', usernamelink)
            .returns('title_ok')

        title = mySvc.getTitle(timeline, event, type)

        expect(title).to.be.equal("title_ok")

    it "title with username not visible", () ->
        timeline = Immutable.fromJS({
            data: {
                user: {
                    username: 'xx',
                    name: 'oo',
                    is_profile_visible: false
                }
            }
        })

        event = {}

        type = {
            key: 'TITLE_USER_NAME',
            translate_params: ['username']
        }

        mockTranslate.instant
            .withArgs('COMMON.SEE_USER_PROFILE', {username: timeline.getIn(['data', 'user', 'username'])})
            .returns('user-param')

        usernamelink = sinon.match ((value) ->
            return value.username == '<span class="username">oo</span>'
         ), "usernamelink"

        mockTranslate.instant
            .withArgs('TITLE_USER_NAME', usernamelink)
            .returns('title_ok')

        title = mySvc.getTitle(timeline, event, type)

        expect(title).to.be.equal("title_ok")

    it "title with a field name", () ->
        timeline = Immutable.fromJS({
            data: {
                value_diff: {
                    key: 'status'
                }
            }
        })

        event = {}

        type = {
            key: 'TITLE_FIELD',
            translate_params: ['field_name']
        }

        mockTranslate.instant
            .withArgs('COMMON.FIELDS.STATUS')
            .returns('field-params')

        fieldparam = sinon.match ((value) ->
            return value.field_name == 'field-params'
         ), "fieldparam"

        mockTranslate.instant
            .withArgs('TITLE_FIELD', fieldparam)
            .returns('title_ok')

        title = mySvc.getTitle(timeline, event, type)

        expect(title).to.be.equal("title_ok")

    it "title with new value", () ->
        timeline = Immutable.fromJS({
            data: {
                value_diff: {
                    key: 'status',
                    value: ['old', 'new']
                }
            }
        })

        event = {}

        type = {
            key: 'NEW_VALUE',
            translate_params: ['new_value']
        }

        mockTranslate.instant
            .withArgs('NEW_VALUE', {new_value: 'new'})
            .returns('new_value_ok')

        title = mySvc.getTitle(timeline, event, type)

        expect(title).to.be.equal("new_value_ok")

    it "title with project name", () ->
        timeline = Immutable.fromJS({
            data: {
                project: {
                    name: "project_name"
                }
            }
        })

        event = {}

        type = {
            key: 'TITLE_PROJECT',
            translate_params: ['project_name']
        }

        projectparam = sinon.match ((value) ->
            return value.project_name == '<a tg-nav="project:project=vm.timeline.getIn([\'data\', \'project\', \'slug\'])" title="project_name">project_name</a>'
         ), "projectparam"

        mockTranslate.instant
            .withArgs('TITLE_PROJECT', projectparam)
            .returns('title_ok')

        title = mySvc.getTitle(timeline, event, type)

        expect(title).to.be.equal("title_ok")

    it "title with sprint name", () ->
        timeline = Immutable.fromJS({
            data: {
                milestone: {
                    name: "milestone_name"
                }
            }
        })

        event = {}

        type = {
            key: 'TITLE_MILESTONE',
            translate_params: ['sprint_name']
        }

        milestoneparam = sinon.match ((value) ->
            return value.sprint_name == '<a tg-nav="project-taskboard:project=vm.timeline.getIn([\'data\', \'project\', \'slug\']),sprint=vm.timeline.getIn([\'data\', \'milestone\', \'slug\'])" title="milestone_name">milestone_name</a>'
         ), "milestoneparam"

        mockTranslate.instant
            .withArgs('TITLE_MILESTONE', milestoneparam)
            .returns('title_ok')

        title = mySvc.getTitle(timeline, event, type)

        expect(title).to.be.equal("title_ok")

    it "title with object", () ->
        timeline = Immutable.fromJS({
            data: {
                issue: {
                    ref: '123',
                    subject: 'subject'
                }
            }
        })

        event = {
            obj: 'issue',
        }

        type = {
            key: 'TITLE_OBJ',
            translate_params: ['obj_name']
        }

        objparam = sinon.match ((value) ->
            return value.obj_name == '<a tg-nav="project-issues-detail:project=vm.timeline.getIn([\'data\', \'project\', \'slug\']),ref=vm.timeline.getIn([\'obj\', \'ref\'])" title="#123 subject">#123 subject</a>'
         ), "objparam"

        mockTranslate.instant
            .withArgs('TITLE_OBJ', objparam)
            .returns('title_ok')

        title = mySvc.getTitle(timeline, event, type)

        expect(title).to.be.equal("title_ok")

    it "title obj wiki", () ->
        timeline = Immutable.fromJS({
            data: {
                wikipage: {
                    slug: 'slug-wiki',
                }
            }
        })

        event = {
            obj: 'wikipage',
        }

        type = {
            key: 'TITLE_OBJ',
            translate_params: ['obj_name']
        }

        objparam = sinon.match ((value) ->
            return value.obj_name ==  '<a tg-nav="project-wiki-page:project=vm.timeline.getIn([\'data\', \'project\', \'slug\']),slug=vm.timeline.getIn([\'obj\', \'ref\'])" title="Slug wiki">Slug wiki</a>'
         ), "objparam"

        mockTranslate.instant
            .withArgs('TITLE_OBJ', objparam)
            .returns('title_ok')

        title = mySvc.getTitle(timeline, event, type)

        expect(title).to.be.equal("title_ok")

    it "title obj milestone", () ->
        timeline = Immutable.fromJS({
            data: {
                milestone: {
                    name: 'milestone_name',
                }
            }
        })

        event = {
            obj: 'milestone',
        }

        type = {
            key: 'TITLE_OBJ',
            translate_params: ['obj_name']
        }

        objparam = sinon.match ((value) ->
            return value.obj_name == '<a tg-nav="project-taskboard:project=vm.timeline.getIn([\'data\', \'project\', \'slug\']),ref=vm.timeline.getIn([\'obj\', \'ref\'])" title="milestone_name">milestone_name</a>'
         ), "objparam"

        mockTranslate.instant
            .withArgs('TITLE_OBJ', objparam)
            .returns('title_ok')

        title = mySvc.getTitle(timeline, event, type)

        expect(title).to.be.equal("title_ok")

    it "task title with us_name", () ->
        timeline = Immutable.fromJS({
            data: {
                task: {
                    name: 'task_name',
                    userstory: {
                        ref: 2
                        subject: 'subject'
                    }
                }
            }
        })

        event = {
            obj: 'task',
        }

        type = {
            key: 'TITLE_OBJ',
            translate_params: ['us_name']
        }

        objparam = sinon.match ((value) ->
            return value.us_name == '<a tg-nav="project-userstories-detail:project=vm.timeline.getIn([\'data\', \'project\', \'slug\']),ref=vm.timeline.getIn([\'obj\', \'userstory\', \'ref\'])" title="#2 subject">#2 subject</a>'
         ), "objparam"

        mockTranslate.instant
            .withArgs('TITLE_OBJ', objparam)
            .returns('title_ok')

        title = mySvc.getTitle(timeline, event, type)

        expect(title).to.be.equal("title_ok")
