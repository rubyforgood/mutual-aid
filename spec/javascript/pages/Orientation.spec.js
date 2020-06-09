import {createLocalVue, mount} from '@vue/test-utils'
import {configure} from 'vue_config'
import Orientation from 'pages/Orientation'


describe('Orientation', () => {
    it ('receives landing_page_text_who', ()=> {
        const wrapper = mount(Orientation, {
            localVue: configure(createLocalVue()),
            propsData: {
                landing_page_text_who: "hello",
            },
        })
        const who_section_description = wrapper.find('#landing_page_text_who .description');

        assert.equal(who_section_description.text(), 'hello')
    })
});
