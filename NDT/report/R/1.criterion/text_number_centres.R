cli::cli_alert_success("Text# of number centres")
cli::cli_alert_info(glue('Saved: {file.path(dir_text_NDT, "1.criterion/number_centres.rds")}'))


survey <- "iaea_ndt"
module <- "inspec"
#get parameters to import and export file
exfile <-file.path(dir_text_NDT, "1.criterion/number_centres.rds")

param <- parameters(mode = survey,
                    module = module)



#import data
inspec <- import(file.path(param$dir_clean_s, "inspection_firms.rds"))
main <- import(file.path(param$dir_clean_s, "iaea_ndt.rds"))

#number of local firms
local_inspec_ct <- prettyNum(sum(inspec$inspec_local_firms), big.mark = ",")
local_train_ct <- prettyNum(sum(main$traincen_local, na.rm =T), big.mark = ",")



test_list <- list(
  
  local_inspec_ct = local_inspec_ct,
  local_train_ct = local_train_ct
  
)


export(test_list, exfile)
