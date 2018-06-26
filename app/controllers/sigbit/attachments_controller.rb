module Sigbit
  class AttachmentsController < Sigbit::ApplicationController

      def destroy
        attachments = ActiveStorage::Blob.find_signed(secure_params[:id]).attachments
        attachments.map(&:purge)
        @attachment_signed_id = secure_params[:id]
      end

      private

      def secure_params
        params.permit(:id)
      end
    end
  end
