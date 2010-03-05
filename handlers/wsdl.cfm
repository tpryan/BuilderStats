<cfheader name="Content-Type" value="text/xml">
<cfsilent>
	<cfscript>
	BaseURL = "http://" & cgi.server_name & ":" & cgi.server_port;
	componentPath = BaseURL & getDirectoryFromPath(cgi.script_name) & "/fileStatsService.cfc";
	</cfscript>;
</cfsilent><?xml version="1.0" encoding="UTF-8"?>
<wsdl:definitions targetNamespace="http://handlers.BuilderStats" xmlns:apachesoap="http://xml.apache.org/xml-soap" xmlns:impl="http://handlers.BuilderStats" xmlns:intf="http://handlers.BuilderStats" xmlns:soapenc="http://schemas.xmlsoap.org/soap/encoding/" xmlns:tns1="http://rpc.xml.coldfusion" xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/" xmlns:wsdlsoap="http://schemas.xmlsoap.org/wsdl/soap/" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
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

   <wsdl:message name="getLineCountsAllResponse">

      <wsdl:part name="getLineCountsAllReturn" type="tns1:QueryBean"/>

   </wsdl:message>

   <wsdl:message name="getLinesByDirectoryResponse">

      <wsdl:part name="getLinesByDirectoryReturn" type="tns1:QueryBean"/>

   </wsdl:message>

   <wsdl:message name="getLinesByExtensionRequest">

      <wsdl:part name="rootPath" type="xsd:string"/>

   </wsdl:message>

   <wsdl:message name="CFCInvocationException">

      <wsdl:part name="fault" type="tns1:CFCInvocationException"/>

   </wsdl:message>

   <wsdl:message name="getGrandTotalRequest">

      <wsdl:part name="rootPath" type="xsd:string"/>

   </wsdl:message>

   <wsdl:message name="getGrandTotalResponse">

      <wsdl:part name="getGrandTotalReturn" type="xsd:double"/>

   </wsdl:message>

   <wsdl:message name="getLinesByDirectoryRequest">

      <wsdl:part name="rootPath" type="xsd:string"/>

   </wsdl:message>

   <wsdl:message name="getLinesByExtensionResponse">

      <wsdl:part name="getLinesByExtensionReturn" type="tns1:QueryBean"/>

   </wsdl:message>

   <wsdl:message name="getLineCountsAllRequest">

      <wsdl:part name="rootPath" type="xsd:string"/>

   </wsdl:message>

   <wsdl:portType name="fileStatsService">

      <wsdl:operation name="getLineCountsAll" parameterOrder="rootPath">

         <wsdl:input message="impl:getLineCountsAllRequest" name="getLineCountsAllRequest"/>

         <wsdl:output message="impl:getLineCountsAllResponse" name="getLineCountsAllResponse"/>

         <wsdl:fault message="impl:CFCInvocationException" name="CFCInvocationException"/>

      </wsdl:operation>

      <wsdl:operation name="getLinesByExtension" parameterOrder="rootPath">

         <wsdl:input message="impl:getLinesByExtensionRequest" name="getLinesByExtensionRequest"/>

         <wsdl:output message="impl:getLinesByExtensionResponse" name="getLinesByExtensionResponse"/>

         <wsdl:fault message="impl:CFCInvocationException" name="CFCInvocationException"/>

      </wsdl:operation>

      <wsdl:operation name="getLinesByDirectory" parameterOrder="rootPath">

         <wsdl:input message="impl:getLinesByDirectoryRequest" name="getLinesByDirectoryRequest"/>

         <wsdl:output message="impl:getLinesByDirectoryResponse" name="getLinesByDirectoryResponse"/>

         <wsdl:fault message="impl:CFCInvocationException" name="CFCInvocationException"/>

      </wsdl:operation>

      <wsdl:operation name="getGrandTotal" parameterOrder="rootPath">

         <wsdl:input message="impl:getGrandTotalRequest" name="getGrandTotalRequest"/>

         <wsdl:output message="impl:getGrandTotalResponse" name="getGrandTotalResponse"/>

         <wsdl:fault message="impl:CFCInvocationException" name="CFCInvocationException"/>

      </wsdl:operation>

   </wsdl:portType>

   <wsdl:binding name="fileStatsService.cfcSoapBinding" type="impl:fileStatsService">

      <wsdlsoap:binding style="rpc" transport="http://schemas.xmlsoap.org/soap/http"/>

      <wsdl:operation name="getLineCountsAll">

         <wsdlsoap:operation soapAction=""/>

         <wsdl:input name="getLineCountsAllRequest">

            <wsdlsoap:body encodingStyle="http://schemas.xmlsoap.org/soap/encoding/" namespace="http://handlers.BuilderStats" use="encoded"/>

         </wsdl:input>

         <wsdl:output name="getLineCountsAllResponse">

            <wsdlsoap:body encodingStyle="http://schemas.xmlsoap.org/soap/encoding/" namespace="http://handlers.BuilderStats" use="encoded"/>

         </wsdl:output>

         <wsdl:fault name="CFCInvocationException">

            <wsdlsoap:fault encodingStyle="http://schemas.xmlsoap.org/soap/encoding/" name="CFCInvocationException" namespace="http://handlers.BuilderStats" use="encoded"/>

         </wsdl:fault>

      </wsdl:operation>

      <wsdl:operation name="getLinesByExtension">

         <wsdlsoap:operation soapAction=""/>

         <wsdl:input name="getLinesByExtensionRequest">

            <wsdlsoap:body encodingStyle="http://schemas.xmlsoap.org/soap/encoding/" namespace="http://handlers.BuilderStats" use="encoded"/>

         </wsdl:input>

         <wsdl:output name="getLinesByExtensionResponse">

            <wsdlsoap:body encodingStyle="http://schemas.xmlsoap.org/soap/encoding/" namespace="http://handlers.BuilderStats" use="encoded"/>

         </wsdl:output>

         <wsdl:fault name="CFCInvocationException">

            <wsdlsoap:fault encodingStyle="http://schemas.xmlsoap.org/soap/encoding/" name="CFCInvocationException" namespace="http://handlers.BuilderStats" use="encoded"/>

         </wsdl:fault>

      </wsdl:operation>

      <wsdl:operation name="getLinesByDirectory">

         <wsdlsoap:operation soapAction=""/>

         <wsdl:input name="getLinesByDirectoryRequest">

            <wsdlsoap:body encodingStyle="http://schemas.xmlsoap.org/soap/encoding/" namespace="http://handlers.BuilderStats" use="encoded"/>

         </wsdl:input>

         <wsdl:output name="getLinesByDirectoryResponse">

            <wsdlsoap:body encodingStyle="http://schemas.xmlsoap.org/soap/encoding/" namespace="http://handlers.BuilderStats" use="encoded"/>

         </wsdl:output>

         <wsdl:fault name="CFCInvocationException">

            <wsdlsoap:fault encodingStyle="http://schemas.xmlsoap.org/soap/encoding/" name="CFCInvocationException" namespace="http://handlers.BuilderStats" use="encoded"/>

         </wsdl:fault>

      </wsdl:operation>

      <wsdl:operation name="getGrandTotal">

         <wsdlsoap:operation soapAction=""/>

         <wsdl:input name="getGrandTotalRequest">

            <wsdlsoap:body encodingStyle="http://schemas.xmlsoap.org/soap/encoding/" namespace="http://handlers.BuilderStats" use="encoded"/>

         </wsdl:input>

         <wsdl:output name="getGrandTotalResponse">

            <wsdlsoap:body encodingStyle="http://schemas.xmlsoap.org/soap/encoding/" namespace="http://handlers.BuilderStats" use="encoded"/>

         </wsdl:output>

         <wsdl:fault name="CFCInvocationException">

            <wsdlsoap:fault encodingStyle="http://schemas.xmlsoap.org/soap/encoding/" name="CFCInvocationException" namespace="http://handlers.BuilderStats" use="encoded"/>

         </wsdl:fault>

      </wsdl:operation>

   </wsdl:binding>

   <wsdl:service name="fileStatsServiceService">

      <wsdl:port binding="impl:fileStatsService.cfcSoapBinding" name="fileStatsService.cfc">

         <wsdlsoap:address location="<cfoutput>#componentPath#</cfoutput>"/>

      </wsdl:port>

   </wsdl:service>
   
   <wsdl:service name="FileStatsServiceService">

      <wsdl:port binding="impl:fileStatsService.cfcSoapBinding" name="fileStatsService.cfc">

         <wsdlsoap:address location="<cfoutput>#componentPath#</cfoutput>"/>

      </wsdl:port>

   </wsdl:service>

</wsdl:definitions>
