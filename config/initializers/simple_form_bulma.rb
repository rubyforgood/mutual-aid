SimpleForm.setup do |config|
  #config.generate_additional_classes_for = ['field']


  # config.error_notification_class = 'alert alert-danger'
  # config.button_class = 'btn btn-default'
  # config.boolean_label_class = nil

  config.wrappers :default, tag: 'div', class: '', error_class: 'has-error' do |b|
    b.use :html5
    b.use :placeholder, class: 'help has-text-grey-light'
    b.use         :placeholder
    b.optional    :maxlength
    b.optional    :pattern
    b.optional    :min_max
    b.optional    :readonly

    b.wrapper tag: 'div', class: 'field' do |ba|
      ba.use :label, class: 'label', wrap_with: { tag: 'label', class: 'label' }
      ba.use :input, class: 'input'
      ba.use :error, wrap_with: { tag: 'span', class: 'help has-text-grey-light' }
      ba.use :hint,  wrap_with: { tag: 'p', class: 'help has-text-grey-light' }
    end
  end

  config.wrappers :inline_input, tag: "div", class: "field is-horizontal" do |b|
    b.wrapper :label, tag: "div", class: "field-label is-normal" do |bl|
      bl.optional :label, class: "label"
    end
    b.wrapper :input, tag: "div", class: "field-body" do |bi|
      bi.wrapper :input, tag: "div", class: "field" do |bf|
        bf.use :input, class: "input"
        bf.optional :hint, wrap_with: {tag: "p", class: "help"}
      end
    end
  end

  config.wrappers :boolean, tag: 'div', class: 'control', error_class: 'has-error' do |b|
    b.use :html5
    b.optional :readonly
    b.wrapper :label, tag: "label", class: "checkbox" do |ba|
      ba.use :input, class: 'checkbox'
      ba.use :label_text
      ba.use :hint, wrap_with: {tag: 'p', class: 'help'}
    end
  end

  config.wrappers :radio_and_checkboxes, tag: 'div', class: 'field', error_class: 'has-error' do |b|
    b.use :html5
    b.optional :readonly
    b.use :label, class: 'label'
    b.wrapper tag: 'div', class: 'control' do |ba|
      ba.use :input, class: 'input'
    end
    b.use :error, wrap_with: { tag: 'span', class: 'help has-text-grey-light' }
    b.use :hint,  wrap_with: { tag: 'p', class: 'help has-text-grey-light' }
  end

  config.wrappers :multi_select, tag: 'div', class: 'field', error_class: 'has-error' do |b|
    b.use :html5
    b.optional :readonly
    b.use :label, class: 'label'
    b.wrapper tag: 'div', class: 'control field is-inline-flex' do |ba|
      ba.use :input, class: 'input'
      ba.use :placeholder, class: 'help has-text-grey-light'
      ba.use :error, wrap_with: { tag: 'span', class: 'help has-text-grey-light' }
      ba.use :hint,  wrap_with: { tag: 'p', class: 'help has-text-grey-light' }
    end
  end

  config.wrappers :vertical_form, tag: 'div', class: '', error_class: 'has-error' do |b|
    b.use :html5
    b.use :placeholder, class: 'help has-text-grey-light'
    b.use         :placeholder
    b.optional    :maxlength
    b.optional    :pattern
    b.optional    :min_max
    b.optional    :readonly

    b.wrapper tag: 'div', class: 'field' do |ba|
      ba.use :label, class: 'label', wrap_with: { tag: 'label', class: 'label' }
      ba.use :input, class: 'input'
      ba.use :error, wrap_with: { tag: 'span', class: 'help has-text-grey-light' }
      ba.use :hint,  wrap_with: { tag: 'p', class: 'help has-text-grey-light' }
    end
  end

  config.wrappers :vertical_file_input, tag: 'div', class: 'field', error_class: 'has-error' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :readonly
    b.use :label, class: 'label'

    b.wrapper tag: 'div', class: 'control' do |ba|
      ba.use :input, class: 'input'
    end
    b.use :error, wrap_with: { tag: 'span', class: 'hint' }
    b.use :hint,  wrap_with: { tag: 'p', class: 'hint' }
  end

  config.wrappers :vertical_boolean, tag: 'div', class: 'field', error_class: 'has-error' do |b|
    b.use :html5
    b.optional :readonly

    b.wrapper tag: 'div', class: 'checkbox' do |ba|
      ba.use :label_input
    end

    b.use :error, wrap_with: { tag: 'span', class: 'hint' }
    b.use :hint,  wrap_with: { tag: 'p', class: 'hint' }
  end

  config.wrappers :vertical_radio_and_checkboxes, tag: 'div', class: 'field', error_class: 'has-error' do |b|
    b.use :html5
    b.optional :readonly
    b.use :label, class: 'label'
    b.wrapper tag: 'div', class: 'control' do |ba|
      ba.use :input, class: 'input'
    end
    b.use :error, wrap_with: { tag: 'span', class: 'hint' }
    b.use :hint,  wrap_with: { tag: 'p', class: 'hint' }
  end

  # Wrappers for forms and inputs
  config.default_wrapper = :vertical_form
  config.wrapper_mappings = {
    check_boxes: :vertical_radio_and_checkboxes,
    radio_buttons: :vertical_radio_and_checkboxes,
    file: :vertical_file_input,
    boolean: :vertical_boolean,
    datetime: :multi_select,
    date: :multi_select,
    time: :multi_select
  }

  class StringInput < SimpleForm::Inputs::StringInput
    def input(wrapper_options)
      template.content_tag(:div, super, class: 'control')
    end
  end

  class TextInput < SimpleForm::Inputs::TextInput
    def input_html_classes
      super.push('textarea')
    end
  end

  class ArrayInput < SimpleForm::Inputs::StringInput
    def input(wrapper_options)
      input_html_options[:type] ||= input_type

      present = Array(object.public_send(attribute_name)).each_with_index.map do |array_el, idx|
        @builder.text_field(nil, input_html_options.merge(value: array_el,
                                                          id: "input_#{object_name}_#{attribute_name}_#{idx}",
                                                          name: "#{object_name}[#{attribute_name}][]"))

      end.join.html_safe

      empty = @builder.text_field(nil, input_html_options.merge(value: nil,
                                                                id: "input_#{object_name}_#{attribute_name}_",
                                                                name: "#{object_name}[#{attribute_name}][]"))

      present + empty
    end

    def input_type
      :text
    end
  end

  class DatePickerInput < SimpleForm::Inputs::StringInput
    def input
      value = @builder.object.send(attribute_name)
      input_html_options[:value] = case value
                                   when Date, Time, DateTime
                                     format = options[:format] || :medium
                                     value.to_s(format)
                                   else
                                     value.to_s
                                   end

      input_html_options[:class] ||= []
      input_html_options[:class] << "date_picker_input"
      @builder.text_field(attribute_name, input_html_options)
    end
  end
end
