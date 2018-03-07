# InvoicIt

Manage and send invoices to your clients easily.


## Contribute

> - I found a bug or want to improve this app, what can I do?
> - I'm glad you ask:

You can follow the backlog on [Trello](https://trello.com/b/LLfi1BG4/invoicit).

1.  [Fork](https://github.com/guillaumecabanel/invoicit#fork-destination-box)

1.  Installation
    ```shell
    bundle install
    rails db.create
    rails db:migrate
    ```

    In development mode, you can use [Mailcatcher](https://github.com/sj26/mailcatcher) to test emails. You should check these [install instructions](https://github.com/sj26/mailcatcher#how).

1.  Configure your environment variables
    ```shell
    cp config/application_example.yml config/application.yml
    ```

    Edit `config/application.yml`.

1.  Code

1.  Pull-request

## License

InvoicIt is released under the [MIT License](https://github.com/guillaumecabanel/invoicit/blob/master/LICENSE).
