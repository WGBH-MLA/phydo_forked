require 'rails_helper'
require_relative '../../../app/search_builders/phydo/catalog_search_builder'

RSpec.describe Phydo::CatalogSearchBuilder do
  let(:me) { create(:user) }

  let(:config) { CatalogController.blacklight_config }

  let(:scope) do
    double('The scope',
           blacklight_config: config,
           current_ability: Ability.new(me),
           current_user: me)
  end

  let(:params) { ActionController::Parameters.new(
    'controller' => 'catalog',
    'action' => 'index') }

  describe '.apply_barcode_filter' do
    let(:params_with_barcode) { ActionController::Parameters.new(
        'controller' => 'catalog',
        'action' => 'index',
        'barcode' => '123456') }

    let(:params_empty_barcode) { ActionController::Parameters.new(
        'controller' => 'catalog',
        'action' => 'index',
        'barcode' => '') }

    let(:builder_with_barcode) { described_class.new(scope).with(params_with_barcode) }

    let(:builder_no_barcode) { described_class.new(scope).with(params) }

    let(:builder_empty_barcode) { described_class.new(scope).with(params_empty_barcode) }

    context 'when there is a barcode in params' do
      subject { builder_with_barcode.query }

      it 'filters for barcode when present in params' do
        expect(subject[:fq]).to include('barcode_ssim:123456')
      end
    end

    context 'when there is no barcode in params' do
      subject { builder_no_barcode.query }

      it 'does not filter for barcode when not in params' do
        expect(subject[:fq]).not_to include('barcode_ssim:')
      end
    end

    context 'when there is an empty barcode in params' do
      subject { builder_empty_barcode.query }

      it 'does not filter for barcode when not in params' do
        expect(subject[:fq]).not_to include('barcode_ssim:')
      end
    end
  end

 describe '.apply_file_path_filter' do
    let(:params_with_file_path) { ActionController::Parameters.new(
        'controller' => 'catalog',
        'action' => 'index',
        'file_path' => '/Volumes/MS COLDER FIELD MASTER CLONE/MSC_ORIGINAL FOOTAGE/MSC_4xx_KiPro_1080_30P/MSC404_Frog_B2_RT/OffloadLogs/AJA.txt') }

    let(:params_empty_barcode) { ActionController::Parameters.new(
        'controller' => 'catalog',
        'action' => 'index',
        'file_path' => '') }

    let(:builder_with_file_path) { described_class.new(scope).with(params_with_file_path) }

    let(:builder_no_barcode) { described_class.new(scope).with(params) }

    let(:builder_empty_file_path) { described_class.new(scope).with(params_empty_barcode) }

    context 'when there is a file_path in params' do
      subject { builder_with_file_path.query }

      it 'filters for file_path when present in params' do
        expect(subject[:fq]).to include("file_path_sim:\"/Volumes/MS COLDER FIELD MASTER CLONE/MSC_ORIGINAL FOOTAGE/MSC_4xx_KiPro_1080_30P/MSC404_Frog_B2_RT/OffloadLogs/AJA.txt\"")
      end
    end

    context 'when there is an empty file_path in params' do
      subject { builder_empty_file_path.query }

      it 'does not filter for file_path when not in params' do
        expect(subject[:fq]).not_to include('file_path_sim:')
      end
    end
  end
end
