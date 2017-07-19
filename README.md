# bedabot

This chatbot uses [API.AI] service, and 


This chatbot uses the natural language [API.AI](https://api.ai) service, and is connected to [slack.com](https://slack.com).
With this **chatbot** you can create a list of frequently asked questions and a list of links.
Here are some commands you can use:
*Create a faq with a tag
*Remove a faq
*Create a link with a tag
*Remove a link

## Dependencies

This app is docker based. To avoid extra configurations, you should have `docker` and `docker-compose` installed. 

## Usage

  * Clone this repo `git clone https://github.com/marcio-soares/bedabot`;
  * In the repo folder, run: 
    * `docker-compose build`;
    * `docker-compose run --rm website rake db:create`;
    * `docker-compose run --rm website rake db:migrate`.

You can start the application running `docker-compose up`.

## Contact
#### Developer/Company
* Homepage: http://www.bedabrazil.com
* e-mail: marcio@mail.com
* Twitter: [@bedabrazil](https://twitter.com/bedabrazil "BedaBrazil on twitter")