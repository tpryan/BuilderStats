<cfheader name="Content-Type" value="text/xml">
<cfsilent>
	<cfscript>
	BaseURL = "http://" & cgi.server_name & ":" & cgi.server_port;
	componentPath = BaseURL & getDirectoryFromPath(cgi.script_name) & "cfcStatsService.cfc";
	</cfscript>;
</cfsilent><wsdl:definitions targetNamespace="http://handlers.BuilderStats" xmlns:apachesoap="http://xml.apache.org/xml-soap" xmlns:impl="http://handlers.BuilderStats" xmlns:intf="http://handlers.BuilderStats" xmlns:soapenc="http://schemas.xmlsoap.org/soap/encoding/" xmlns:tns1="http://rpc.xml.coldfusion" xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/" xmlns:wsdlsoap="http://schemas.xmlsoap.org/wsdl/soap/" xmlns:xsd="http://www.w3.org/2001/XMLSchema"> 
<!--WSDL created by ColdFusion version 9,0,0,251028--> 
 <wsdl:types> 
  <schema targetNamespace="http://handlers.BuilderStats" xmlns="http://www.w3.org/2001/XMLSchema"> 
   <import namespace="http://rpc.xml.coldfusion"/> 
   <import namespace="http://schemas.xmlsoap.org/soap/encoding/"/> 
   <complexType name="ArrayOf_xsd_string"> 
    <complexContent> 
     <restriction base="soapenc:Array"> 
      <attribute ref="soapenc:arrayType" wsdl:arrayType="xsd:string[]"/> 
     </restriction> 
    </complexContent> 
   </complexType> 
   <complexType name="ArrayOfArrayOf_xsd_anyType"> 
    <complexContent> 
     <restriction base="soapenc:Array"> 
      <attribute ref="soapenc:arrayType" wsdl:arrayType="xsd:anyType[][]"/> 
     </restriction> 
    </complexContent> 
   </complexType> 
  </schema> 
  <schema targetNamespace="http://rpc.xml.coldfusion" xmlns="http://www.w3.org/2001/XMLSchema"> 
   <import namespace="http://handlers.BuilderStats"/> 
   <import namespace="http://schemas.xmlsoap.org/soap/encoding/"/> 
   <complexType name="QueryBean"> 
    <sequence> 
     <element name="columnList" nillable="true" type="impl:ArrayOf_xsd_string"/> 
     <element name="data" nillable="true" type="impl:ArrayOfArrayOf_xsd_anyType"/> 
    </sequence> 
   </complexType> 
   <complexType name="CFCInvocationException"> 
    <sequence/> 
   </complexType> 
  </schema> 
 </wsdl:types> 
 
   <wsdl:message name="getHintedCountsResponse"> 
 
      <wsdl:part name="getHintedCountsReturn" type="tns1:QueryBean"/> 
 
   </wsdl:message> 
 
   <wsdl:message name="getimplicitCountsRequest"> 
 
      <wsdl:part name="rootPath" type="xsd:string"/> 
 
   </wsdl:message> 
 
   <wsdl:message name="CFCInvocationException"> 
 
      <wsdl:part name="fault" type="tns1:CFCInvocationException"/> 
 
   </wsdl:message> 
 
   <wsdl:message name="getHintedCountsRequest"> 
 
      <wsdl:part name="rootPath" type="xsd:string"/> 
 
   </wsdl:message> 
 
   <wsdl:message name="getBaseStatsResponse"> 
 
      <wsdl:part name="getBaseStatsReturn" type="tns1:QueryBean"/> 
 
   </wsdl:message> 
 
   <wsdl:message name="getimplicitCountsResponse"> 
 
      <wsdl:part name="getimplicitCountsReturn" type="tns1:QueryBean"/> 
 
   </wsdl:message> 
 
   <wsdl:message name="getBaseStatsRequest"> 
 
      <wsdl:part name="rootPath" type="xsd:string"/> 
 
   </wsdl:message> 
 
   <wsdl:portType name="cfcStatsService"> 
 
      <wsdl:operation name="getBaseStats" parameterOrder="rootPath"> 
 
         <wsdl:input message="impl:getBaseStatsRequest" name="getBaseStatsRequest"/> 
 
         <wsdl:output message="impl:getBaseStatsResponse" name="getBaseStatsResponse"/> 
 
         <wsdl:fault message="impl:CFCInvocationException" name="CFCInvocationException"/> 
 
      </wsdl:operation> 
 
      <wsdl:operation name="getHintedCounts" parameterOrder="rootPath"> 
 
         <wsdl:input message="impl:getHintedCountsRequest" name="getHintedCountsRequest"/> 
 
         <wsdl:output message="impl:getHintedCountsResponse" name="getHintedCountsResponse"/> 
 
         <wsdl:fault message="impl:CFCInvocationException" name="CFCInvocationException"/> 
 
      </wsdl:operation> 
 
      <wsdl:operation name="getimplicitCounts" parameterOrder="rootPath"> 
 
         <wsdl:input message="impl:getimplicitCountsRequest" name="getimplicitCountsRequest"/> 
 
         <wsdl:output message="impl:getimplicitCountsResponse" name="getimplicitCountsResponse"/> 
 
         <wsdl:fault message="impl:CFCInvocationException" name="CFCInvocationException"/> 
 
      </wsdl:operation> 
 
   </wsdl:portType> 
 
   <wsdl:binding name="cfcStatsService.cfcSoapBinding" type="impl:cfcStatsService"> 
 
      <wsdlsoap:binding style="rpc" transport="http://schemas.xmlsoap.org/soap/http"/> 
 
      <wsdl:operation name="getBaseStats"> 
 
         <wsdlsoap:operation soapAction=""/> 
 
         <wsdl:input name="getBaseStatsRequest"> 
 
            <wsdlsoap:body encodingStyle="http://schemas.xmlsoap.org/soap/encoding/" namespace="http://handlers.BuilderStats" use="encoded"/> 
 
         </wsdl:input> 
 
         <wsdl:output name="getBaseStatsResponse"> 
 
            <wsdlsoap:body encodingStyle="http://schemas.xmlsoap.org/soap/encoding/" namespace="http://handlers.BuilderStats" use="encoded"/> 
 
         </wsdl:output> 
 
         <wsdl:fault name="CFCInvocationException"> 
 
            <wsdlsoap:fault encodingStyle="http://schemas.xmlsoap.org/soap/encoding/" name="CFCInvocationException" namespace="http://handlers.BuilderStats" use="encoded"/> 
 
         </wsdl:fault> 
 
      </wsdl:operation> 
 
      <wsdl:operation name="getHintedCounts"> 
 
         <wsdlsoap:operation soapAction=""/> 
 
         <wsdl:input name="getHintedCountsRequest"> 
 
            <wsdlsoap:body encodingStyle="http://schemas.xmlsoap.org/soap/encoding/" namespace="http://handlers.BuilderStats" use="encoded"/> 
 
         </wsdl:input> 
 
         <wsdl:output name="getHintedCountsResponse"> 
 
            <wsdlsoap:body encodingStyle="http://schemas.xmlsoap.org/soap/encoding/" namespace="http://handlers.BuilderStats" use="encoded"/> 
 
         </wsdl:output> 
 
         <wsdl:fault name="CFCInvocationException"> 
 
            <wsdlsoap:fault encodingStyle="http://schemas.xmlsoap.org/soap/encoding/" name="CFCInvocationException" namespace="http://handlers.BuilderStats" use="encoded"/> 
 
         </wsdl:fault> 
 
      </wsdl:operation> 
 
      <wsdl:operation name="getimplicitCounts"> 
 
         <wsdlsoap:operation soapAction=""/> 
 
         <wsdl:input name="getimplicitCountsRequest"> 
 
            <wsdlsoap:body encodingStyle="http://schemas.xmlsoap.org/soap/encoding/" namespace="http://handlers.BuilderStats" use="encoded"/> 
 
         </wsdl:input> 
 
         <wsdl:output name="getimplicitCountsResponse"> 
 
            <wsdlsoap:body encodingStyle="http://schemas.xmlsoap.org/soap/encoding/" namespace="http://handlers.BuilderStats" use="encoded"/> 
 
         </wsdl:output> 
 
         <wsdl:fault name="CFCInvocationException"> 
 
            <wsdlsoap:fault encodingStyle="http://schemas.xmlsoap.org/soap/encoding/" name="CFCInvocationException" namespace="http://handlers.BuilderStats" use="encoded"/> 
 
         </wsdl:fault> 
 
      </wsdl:operation> 
 
   </wsdl:binding>
   
   <wsdl:service name="cfcStatsServiceService"> 
 
      <wsdl:port binding="impl:cfcStatsService.cfcSoapBinding" name="cfcStatsService.cfc"> 
 
         <wsdlsoap:address location="<cfoutput>#componentPath#</cfoutput>"/> 
 
      </wsdl:port> 
 
   </wsdl:service>
 
</wsdl:definitions> 