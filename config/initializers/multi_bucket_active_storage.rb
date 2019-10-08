module Methods
    def set_bucket(bucket)
      @bucket = bucket
    end
  end
  ActiveStorage::Service.module_eval { attr_writer :bucket }
  ActiveStorage::Service.class_eval { include Methods }