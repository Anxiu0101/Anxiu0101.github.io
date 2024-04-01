---
title: Use-Case-Accelerant-Extraction-Service
date: 2024-03-27 09:29:39
tags: []
categories: []
published: true
---

今天，我们很高兴宣布我们最新的 OSS 用例加速器：提取服务。 LLMS是从非结构化来源提取结构化数据的强大工具。 在过去的几个版本中，我们改善了对开源 Langchain 库中数据提取的支持，现在我们正在使用一个入门存储库进一步迈出一步，以帮助您构建自己的提取应用程序。

入门存储库包括一个裸露的 Web 应用程序，该应用程序可以扩展以构建一个自助提取应用程序，该应用程序可以被组织中的非技术用户使用，以利用 LLMs 的功率进行数据提取。

我们将在下面更详细地讨论提取服务，但首先，让我们讨论提取用例以及LLMs如何提供帮助。

Today we’re excited to announce our newest OSS use-case accelerant: an [extraction](https://github.com/langchain-ai/langchain-extract?ref=blog.langchain.dev) [service](https://github.com/langchain-ai/langchain-extract?ref=blog.langchain.dev). LLMs are a powerful tool for extracting structured data from unstructured sources. We've improved our [support for data extraction](https://python.langchain.com/docs/use_cases/extraction/?ref=blog.langchain.dev) in the open source LangChain library over the past few releases, and now we’re taking that a step further with a starter repository to help you build your own extraction application.

[The starter repository](https://github.com/langchain-ai/langchain-extract?ref=blog.langchain.dev) includes a bare-bones web application that can be extended to build a self-service extraction application that can be used by non-technical users in your organization to leverage the power of LLMs for data extraction.

We'll discuss the extraction service in more detail below, but first, let's discuss the extraction use case and how LLMs can help.

## The Extraction Use Case

企业花费大量资源和精力从非结构化的数据源中获得有价值的见解，其中包括 PDFs 和 PowerPoint 演示文稿，网站以及其他文本信息等文本信息等文本诸如产品评论和客户反馈。

通常部署的提取解决方案倾向于依靠涉及人手动工作的方法的混合，以及使用手工制作的规则或自定义的微调ML模型进行的自动提取。

对于自动解决方案，公司一直从基于规则的方法论转移到基于机器学习的解决方案（ML）的解决方案，并认识到ML驱动的方法通常在其系统中提供了更大的可扩展性和可维护性。

前几代基于ML的解决方案的主要问题是，它们通常需要大量的努力来构建和维护，以及大量标记的数据来训练模型。

大型语言模型（LLM）已成为一种有能力的新ML技术，可以帮助提供信息提取应用程序。 仅通过向其提供适当的说明（以提示的形式）和适当的参考示例，可以将LLMS适应特定的提取任务。 结果，LLMS大大降低了采用AI第一种信息提取方法的障碍。

新一代的信息提取解决方案将建立在LLM的顶部。 这种解决方案仍将涉及人类的人类，以向LLM提供反馈和指导，以及一定数量的自定义规则和启发式方法来处理边缘案例。 此类解决方案仍然需要一个工作流程工具来管理数据提取和验证过程。 但是，这种解决方案将比前几代解决方案变得更加可扩展和可维护。

Enterprises spend substantial resources and effort to derive valuable insights from unstructured data sources, which encompass documents such as PDFs and PowerPoint presentations, websites, and other textual information like product reviews and customer feedback.

Commonly deployed extraction solutions tend to rely on a mixture of approaches that involve manual work done by people, and automated extraction done using either hand-crafted rules or custom fine-tuned ML models.

For automated solutions, companies have been shifting away from rule-based methodologies to machine learning (ML)-based solutions, recognizing that ML-driven approaches typically offer greater scalability and maintainability in their systems.

The main problem with previous generations of ML-based solutions is that they often require significant effort to build and maintain, as well as a significant amount of labeled data to train the models.

Large Language Models (LLMs) have emerged as a capable new ML technology that can help power information extraction applications. LLMs can be adapted for specific extraction tasks just by providing appropriate instructions to them (in the form of a prompt) and appropriate reference examples. As a result, LLMs significantly reduce the barrier to adopt an AI first approach to information extraction.

The new generation of solutions to information extraction will be built on top of LLMs. Such solutions will still involve human-in-the-loop to provide feedback and guidance to the LLMs, and some amount of custom rules and heuristics to handle edge cases. Such solutions will still require a workflow tool to manage the data extraction and validation process. But such solutions will become significantly more scalable and maintainable than the previous generations of solutions.

## LLMs to the Rescue

How do you use an LLM for information extraction? Here, we’ll outline the essential components and high level and high level considerations that should go into building an extraction service.

#### The raw data

Extracting information using an LLM starts with the data you wish to extract from, which first needs to be converted into a text format. LangChain contains [hundreds of document loaders](https://python.langchain.com/docs/integrations/document_loaders?ref=blog.langchain.dev) that you can use to parse files like PDFs and convert to a textual format.

After loading the text, you need to decide how to present it to the LLM. The simplest thing to do is to present the entire text to the LLM. This is great for small pieces of text, but has several pitfalls for longer texts. First, it may not all fit into the context window. Second, assuming it does, most language models perform worse on longer inputs, so putting it all in context may yield worse results. Third, even if the results are comparable, the inference time will take a while.

A more sophisticated approach involves segmenting the text into chunks and processing only the relevant ones through the LLM. This of course introduces the complication of having to decide which chunks are relevant. Alternatively, you could extract content from all the chunks in parallel which will guarantee you don’t miss any relevant chunks. Either way you will need to decide how to best combine results from across the chunks and how to deal with information that’s been broken up across separate chunks.

#### Describe what you want

If you want the LLM to extract information effectively, you need to provide it with a description of what you want extracted.

Such a description can be broken down into three key components:

1. A schema that describes the structure of the data you want to extract.
2. A prompt that provides context for the extraction and primes the LLM.
3. Reference examples that show examples of extractions from text.

#### How to make it work

So these are the components, but how do you actually make it work? 

There are two simple but powerful ideas we’d like to cover here.

The first key idea is making sure the LLM responds in a correct format. If you instruct an LLM to output JSON in its prompt, it may not always do so. Function calling has emerged as a new and relatively reliable way to enforce that LLMs output a specific format. We would recommend using this for improved performance. 

Check out the [structured output docs](https://python.langchain.com/docs/guides/structured_output?ref=blog.langchain.dev) for a high level LangChain API that shows tool / function calling with different LLMs.

Another tip for improving performance is to use reference examples. While you can set up an extraction problem without any reference examples, we have found that in practice it is highly beneficial to include examples of inputs and corresponding outputs. These can often be more helpful than instructions in terms of showing the LLM how to handle specific situations.

We have included further details in the [extraction use case docs](https://python.langchain.com/docs/use_cases/extraction/?ref=blog.langchain.dev) that will help you squeeze performance from your LLMs.

## The Service

With this in mind, what exactly does our [extraction service](https://github.com/langchain-ai/langchain-extract?ref=blog.langchain.dev) provide?

The service is built on top of FastAPI and Postgresql. It exposes a standard REST API, and comes with a docker-compose file to help you spin up the stack quickly. The service is a bare-bones web application that can be extended to create an extraction application for non-technical users in your organization. This is essentially boilerplate that you can use to jumpstart your application development. Alternatively, you can just use it as is for your own extraction workflows without doing any further development.

The API allows defining and persisting "extractors" which contain the key components needed to configure an LLM for extraction. These components include a schema that describes the structure of the data you want to extract, a prompt that provides context for the extraction and primes the model, and reference examples that show the model some examples of extractions. 

In addition, the API exposes an extraction endpoint that allow you to submit files for extraction using an existing extractor, and a second variant of the endpoint that allows you to use a RemoteRunnable to easily use the service as part of a larger LangChain Expression Language (LCEL) chain.

The service is pre-configured with a MIME-type based parser and supports parsing of PDFs and HTML files. You can easily extend this to support other types of files (e.g., PowerPoint) using existing [LangChain document loaders and parsers](https://python.langchain.com/docs/integrations/document_loaders?ref=blog.langchain.dev).

One key decision we’ve made for the extraction API is that we’ve designed it to always extract multiple entities. This is usually the desired behavior when extracting from text because it allows the model to extract multiple entities if they’re present, and also because it allows the model to extract no entities if the text contains no relevant information.

How do you actually use this service? 

Building off the above, there are a few usage considerations. You can use JSON schema to define exactly what to extract. You can specify examples that will be incorporated to improve the quality of extracted results. You can either specify these when invoking the API, or you can create and save extractors and examples in a database. This will make it easy to save and share extractors. In terms of passing in the text, you can either pass in raw text or binary files.

## Example

Let’s take a look at an example of how to use this service.

First, you can [create an extractor](https://github.com/langchain-ai/langchain-extract?tab=readme-ov-file&ref=blog.langchain.dev#create-an-extractor):

```python
curl -X 'POST' \
  'http://localhost:8000/extractors' \
  -H 'accept: application/json' \
  -H 'Content-Type: application/json' \
  -d '{
  "name": "Personal Information",
  "description": "Use to extract personal information",
  "schema": {
      "type": "object",
      "title": "Person",
      "required": [
        "name",
        "age"
      ],
      "properties": {
        "age": {
          "type": "integer",
          "title": "Age"
        },
        "name": {
          "type": "string",
          "title": "Name"
        }
      }
    },
  "instruction": "Use information about the person from the given user input."
}'
```

What is this doing?

First, we are sending a name parameter to the service - this is just a simple human readable name for the extractor we are creating, not to be used by the LLM. Likewise, the description parameter is just for tracking purposes, not used in any way.

The schema parameter is used by the service. This is the JSON schema representing the schema of the objects we are trying to extract. We are extracting a Person schema, with two attributes, both of which are required: age (an integer) and name (a string).

The instruction parameter is also used by the service. These instructions are sent to the LLM along with the schema and the text and can provide additional context and instruction for how the LLM should behave.

When we send this, we get back a response corresponding to the id of the extractor we just created:

```python
{
  "uuid": "32d5324a-8a48-4073-b57c-0a2ebfb0bf5e"
}
```

After having registered it, we can then [invoke it](https://github.com/langchain-ai/langchain-extract?tab=readme-ov-file&ref=blog.langchain.dev#create-an-extractor):

```python
curl -s -X 'POST' \
'http://localhost:8000/extract' \
-H 'accept: application/json' \
-H 'Content-Type: multipart/form-data' \
-F 'extractor_id=32d5324a-8a48-4073-b57c-0a2ebfb0bf5e' \
-F 'text=my name is chester and i am 20 years old. My name is eugene and I am 1 year older than chester.' \
-F 'mode=entire_document' \
-F 'file=' | jq .
```

We are passing in an extractor_id - this is the id returned from the step before.

We also pass in text - this is the text to extract information from.

We specify mode=entire_document. This is telling the service to extract from the whole document. If the text we were extracting from was larger, we may want to handle it differently - this is where we control that parameter.

Finally, we pass a file with an empty value. This service also accepts file uploads, but we are not using that here

We get back the following response:

```python
{
  "data": [
    {
      "name": "chester",
      "age": 20
    },
    {
      "name": "eugene",
      "age": 21
    }
  ]
}
```

## Conclusion

In this blog we’ve introduced the idea of using LLMs to extract structured data from unstructured text, introduced our fully [open source repository](https://github.com/langchain-ai/langchain-extract?ref=blog.langchain.dev) that exposes a service to do this, and ran through a relatively simple example of how to use it. For more complex examples, you can check out the [readme](https://github.com/langchain-ai/langchain-extract?ref=blog.langchain.dev) of the service. For information on how to do extraction using LangChain without using this service, you can check out our updated [use case documentation](https://python.langchain.com/docs/use_cases/extraction/?ref=blog.langchain.dev). Over the next week or so we will be adding a relatively simple frontend for this service and exposing a hosted version of it. We’d love any feedback!

Additional Resources:

- [LangChain-extract](https://python.langchain.com/docs/use_cases/extraction/?ref=blog.langchain.dev) - the repository that contains the service code
- [LangChain Extraction documentation](https://python.langchain.com/docs/use_cases/extraction/?ref=blog.langchain.dev) – documentation that shows how to do extraction using LangChain
- [Structured Output Functionality](https://python.langchain.com/docs/guides/structured_output?ref=blog.langchain.dev) - High level LangChain API to structure output using different models capable of function/tool calling
- [Function Calling](https://python.langchain.com/docs/modules/model_io/chat/function_calling?ref=blog.langchain.dev) - function calling in more detail
- [LangChain-benchmarks](https://github.com/langchain-ai/langchain-benchmarks?ref=blog.langchain.dev) -a repository that contains benchmarking code that you can use to evaluate different LLMs
