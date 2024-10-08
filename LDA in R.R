library(XML)
library(tm)
library(SnowballC)
library(textstem)

# Function to parse XML and extract the Body content
parse_xml <- function(file_path) {
  xml_data <- xmlTreeParse(file_path, useInternalNodes = TRUE)
  root_node <- xmlRoot(xml_data)
  body_texts <- xpathSApply(root_node, "//row/@Title")
  return(body_texts)
}

# Function to clean the text data
clean_text <- function(texts) {
  # Convert to a corpus with unique document identifiers
  corpus <- Corpus(VectorSource(texts))
  for (i in seq_along(corpus)) {
    meta(corpus[[i]], "id") <- as.character(i)
  }
  
  print(paste("Initial number of documents:", length(corpus)))
  
  # Define a function to clean HTML tags
  clean_html <- content_transformer(function(x) {
    return(gsub("<.*?>", "", x))
  })
  
  # Define a function to remove custom stop words
  removeCustomStopwords <- content_transformer(function(x, stopwords) {
    x <- unlist(strsplit(as.character(x), "\\s+"))
    x <- x[!(x %in% stopwords)]
    paste(x, collapse = " ")
  })
  
  # Apply cleaning transformations
  corpus <- tm_map(corpus, clean_html)
  corpus <- tm_map(corpus, content_transformer(tolower))
  corpus <- tm_map(corpus, removePunctuation)
  corpus <- tm_map(corpus, removeNumbers)
  corpus <- tm_map(corpus, removeCustomStopwords, custom_stopwords)
  corpus <- tm_map(corpus, removeWords, stopwords("en"))
  corpus <- tm_map(corpus, stripWhitespace)
  
  # Remove empty documents after initial cleaning
  corpus <- corpus[which(sapply(corpus, function(x) nchar(as.character(x))) > 0)]
  print(paste("After initial cleaning, number of documents:", length(corpus)))
  
  # Convert corpus to a character vector for lemmatization
  corpus_texts <- sapply(corpus, as.character)
  corpus_texts <- corpus_texts[nchar(corpus_texts) > 0]
  print(paste("After removing empty texts, number of documents:", length(corpus_texts)))
  
  # Perform lemmatization
  lemmatized_texts <- lemmatize_strings(corpus_texts)
  lemmatized_texts <- lemmatized_texts[nchar(lemmatized_texts) > 0]
  print(paste("After lemmatization, number of documents:", length(lemmatized_texts)))
  
  # Create a new corpus from the lemmatized texts
  lemmatized_corpus <- Corpus(VectorSource(lemmatized_texts))
  
  # Perform stemming on the lemmatized corpus
  stemmed_corpus <- tm_map(lemmatized_corpus, stemDocument)
  
  # Convert to a character vector and remove empty documents after stemming
  stemmed_texts <- sapply(stemmed_corpus, as.character)
  stemmed_texts <- stemmed_texts[nchar(stemmed_texts) > 0]
  print(paste("After stemming, number of documents:", length(stemmed_texts)))
  
  # Create the final cleaned corpus
  final_corpus <- Corpus(VectorSource(stemmed_texts))
  print(paste("Final number of documents:", length(final_corpus)))
  
  return(final_corpus)
}

# Example usage
file_path <- "Posts.xml"
body_texts <- parse_xml(file_path)
custom_stopwords <- c("can","folk","use","possible","science","computer","good","teach","learn","student")
cleaned_corpus <- clean_text(body_texts)


# Create the Document-Term Matrix with unique terms
dtm <- DocumentTermMatrix(cleaned_corpus,
                          control = list(wordLengths = c(3, Inf), # Ignore short words
                                         bounds = list(global = c(1, Inf)))) # Ignore infrequent words

# Inspect the document-term matrix
inspect(dtm)

library(topicmodels)
# Fit the LDA model
start_time <- Sys.time()
lda_model <- LDA(dtm, k = 10)
end_time <- Sys.time()
print(end_time - start_time)

terms(lda_model, 10)
topics(lda_model)
