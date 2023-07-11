class TailwindFormBuilder < ActionView::Helpers::FormBuilder
  
  def text_field(method, opts={})
    default_opts = { class: "mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-300 focus:ring focus:ring-indigo-200 focus:ring-opacity-50 #{'border-2 border-red-500' if @object.errors.any?}" }
    merged_opts = default_opts.merge(opts)
    super(method, merged_opts)
  end

   def label(method, text = nil, options = {})
      default_style = "block text-gray-500 md:text-left mb-1 md:mb-0 pr-4"
      super(method, text, options.merge({class: default_style}))
    end
  
end