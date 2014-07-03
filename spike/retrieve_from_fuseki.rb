require 'net/http'
require 'cgi'
require 'json'

def get_fuseki_articles
    json = get_fuseki_json
    json_header = json["head"]["vars"]

    subject_var = json_header[0]
    predicate_var = json_header[1]
    object_var = json_header[2]

    json_triples = json["results"]["bindings"]

    articles = {}
    json_triples.each do |triple|
        subject = get_subject_name(subject_var, triple)
        predicate = get_predicate_name(predicate_var, triple)
        object = get_object_value(object_var, triple)

        subject_hash = get_subject_from_hash(articles, subject)
        subject_hash[predicate] = object
    end
    articles.to_a.map {|entry| entry[1]}
end

def get_fuseki_json
    query = CGI::escape('SELECT * {?subject ?predicate ?object}')
    uri = URI('http://localhost:3030/articles/query?query=' + query)
    res = Net::HTTP.get(uri)
    JSON.parse(res)
end

def get_subject_name(var_name, triple)
    triple[var_name]["value"]
end

def get_predicate_name(var_name, triple)
    predicate_url = triple[var_name]["value"]
    predicate = predicate_url.split(/\/|#/)[-1]
    predicate
end

def get_object_value(var_name, triple)
    triple[var_name]["value"]
end

def get_subject_from_hash(hash, subject)
    hash[subject] = hash[subject] || {}
end

articles = get_fuseki_articles
puts articles[0]
