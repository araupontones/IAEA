#download data

susor_login(susor_server = "http://www.pulpodata.solutions",
            susor_user = "araupontones",
            susor_password = "Seguridad1",
            susor_dir_downloads = dir_downloads,
            susor_dir_raw = dir_raw
            
)


#View(susor_questionnaires)

#NDT----------------------------------------------------------------------------
susor_export_file(susor_qn_variable = "iaea_ndt",
                  susor_qn_version = 4)



susor_append_versions(susor_qn_variable = "iaea_ndt",
                      susor_format = "STATA"
)



#RT-----------------------------------------------------------------------------
susor_export_file(susor_qn_variable = "iaea_rt",
                  susor_qn_version = 5)


susor_append_versions(susor_qn_variable = "iaea_rt",
                      susor_format = "STATA"
)
