require 'test_helper'

class DocxSynthesizerTest < Minitest::Test
  def setup
    @context = {
      user: {
        name: 'Phil Chen'
      },
      field_1: 1,
      field_2: 'B',
      field_3: [3, 'C', '3&C', '3<=>4'],
      # field_4: DocxSynthesizer::Variable::Image.new('看不见的客人.jpg', url: 'https://img1.doubanio.com/view/activity_page/raw/public/p2638.jpg')
      field_4: [
        DocxSynthesizer::Variable::Image.new('看不见的客人.jpg', url: 'https://img1.doubanio.com/view/activity_page/raw/public/p2638.jpg'),
        DocxSynthesizer::Variable::Hyperlink.new('Skylark', url: 'https://skylarkly.com'),
        4,
        'D'
      ],
      field_5: DocxSynthesizer::Variable::Image.new('douban-reading.jpg', url: 'https://img3.doubanio.com/icon/u113894409-4.jpg'),
      field_6: DocxSynthesizer::Variable::Image.new('cant-load.png', url: 'https://img3.doubanio.com/not-found.png'),
      field_7: [
        DocxSynthesizer::Variable::Hyperlink.new('Escape Link', url: 'https://skylarkly.com?id=1&name=2&age>1&age<2'),
        DocxSynthesizer::Variable::Hyperlink.new('cant-load.png', url: 'https://img3.doubanio.com/not-found.png'),
        DocxSynthesizer::Variable::Hyperlink.new('下载失败', url: 'https://img3.doubanio.com/not-found.png'),
        'Hyperlink'
      ]
    }
  end

  def test_render
    template = DocxSynthesizer.template(File.expand_path("../template.docx", __FILE__))
    template.render_to_file(@context, File.expand_path("../generated.docx", __FILE__))
  end

  def test_template_with_buffer
    template = DocxSynthesizer.template(File.read(File.expand_path("../template.docx", __FILE__)))
    template.render_to_file(@context, File.expand_path("../generated_from_buffer.docx", __FILE__))
  end
end
