PROJECT FOR RUNNING REDSHIFT MIGRATIONS

Verified to work with ruby 2.1.2

CREATING A MIGRATION
====================
1. Create your migration file with `rails generate migration MIGRATION_NAME_HERE`
2. Move migration file to proper db subdirectory, ```common``` for migrations to be run on both clusters.
3. Test it out on sandbox (`rake db:migrate_sandbox` locally will run migrations to both sandbox DBs)
4. Make a PR
5. After the PR gets merged, run the migration on production with `rake db:migrate_production`

RUNNING A MIGRATION
===================
1. Option 1: Single cluster
  - ```rake db:migrate_sandbox_engineering```
  - ```rake db:migrate_sandbox_ops```
  - ```rake db:migrate_production_ops```
  - ```rake db:migrate_production_engineering```
2. Option 2: Multi-cluster
  - ```rake db:migrate_sandbox```
  - ```rake db:migrate_production```

ROLLING BACK A MIGRATION
========================
1. Option 1: Single cluster
  - ```rake db:rollback_sandbox_engineering```
  - ```rake db:rollback_sandbox_ops```
  - ```rake db:rollback_production_ops```
  - ```rake db:rollback_production_engineering```
2. Option 2: Multi-cluster
  - ```rake db:rollback_sandbox```
  - ~~```rake db:rollback_production```~~ Nope, rolling back migrations on multiple prod clusters is dangerous because you could be rolling back two different migrations!

NOTE
====
Do not chain multiple targets when using these rake tasks!
