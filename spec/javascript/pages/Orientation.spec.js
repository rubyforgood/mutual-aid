import {createLocalVue, mount} from '@vue/test-utils'
import {configure} from 'vue_config'
import Orientation from 'pages/Orientation'

describe('Orientation', () => {
    it ('receives landing_page_text_what', ()=> {
        const wrapper = mount(Orientation, {
            localVue: configure(createLocalVue()),
            propsData: {
                landing_page_text_what: "hello123",
            },
        })
        const what_section_description = wrapper.find('#landing_page_text_what .description');

        assert.equal(what_section_description.text(), 'hello123')
    })

    it ('receives landing_page_text_who', ()=> {
        const wrapper = mount(Orientation, {
            localVue: configure(createLocalVue()),
            propsData: {
                landing_page_text_who: "hello1234",
            },
        })
        const who_section_description = wrapper.find('#landing_page_text_who .description');

        assert.equal(who_section_description.text(), 'hello1234')
    })

    it ('receives landing_page_text_how', ()=> {
        const wrapper = mount(Orientation, {
            localVue: configure(createLocalVue()),
            propsData: {
                landing_page_text_how: "hello12345",
            },
        })
        const how_section_description = wrapper.find('#landing_page_text_how .description');

        assert.equal(how_section_description.text(), 'hello12345')
    })
});
