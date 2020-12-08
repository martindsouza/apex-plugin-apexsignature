prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- ORACLE Application Express (APEX) export file
--
-- You should run the script connected to SQL*Plus as the Oracle user
-- APEX_200200 or as the owner (parsing schema) of the application.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_api.import_begin (
 p_version_yyyy_mm_dd=>'2020.10.01'
,p_release=>'20.2.0.00.20'
,p_default_workspace_id=>9492896460309533
,p_default_application_id=>134
,p_default_id_offset=>9509174155607149
,p_default_owner=>'BBSPRO'
);
end;
/
 
prompt APPLICATION 134 - BBSPro
--
-- Application Export:
--   Application:     134
--   Name:            BBSPro
--   Date and Time:   17:34 Tuesday December 8, 2020
--   Exported By:     MDSOUZA
--   Flashback:       0
--   Export Type:     Component Export
--   Manifest
--     PLUGIN: 61258584527411566
--   Manifest End
--   Version:         20.2.0.00.20
--   Instance ID:     9288633072662471
--

begin
  -- replace components
  wwv_flow_api.g_mode := 'REPLACE';
end;
/
prompt --application/shared_components/plugins/region_type/de_danielh_apexsignature
begin
wwv_flow_api.create_plugin(
 p_id=>wwv_flow_api.id(61258584527411566)
,p_plugin_type=>'REGION TYPE'
,p_name=>'DE.DANIELH.APEXSIGNATURE'
,p_display_name=>'APEX Signature'
,p_supported_ui_types=>'DESKTOP'
,p_plsql_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'/*-------------------------------------',
' * APEX Signature',
' * Version: 1.1 (25.04.2016)',
' * Author:  Daniel Hochleitner',
' *-------------------------------------',
'*/',
'FUNCTION render_apexsignature(p_region              IN apex_plugin.t_region,',
'                              p_plugin              IN apex_plugin.t_plugin,',
'                              p_is_printer_friendly IN BOOLEAN)',
'  RETURN apex_plugin.t_region_render_result IS',
'  -- plugin attributes',
'  l_width              NUMBER := p_region.attribute_01;',
'  l_height             NUMBER := p_region.attribute_02;',
'  l_line_minwidth      VARCHAR2(50) := p_region.attribute_03;',
'  l_line_maxwidth      VARCHAR2(50) := p_region.attribute_04;',
'  l_background_color   VARCHAR2(100) := p_region.attribute_05;',
'  l_pen_color          VARCHAR2(100) := p_region.attribute_06;',
'  l_logging            VARCHAR2(50) := p_region.attribute_08;',
'  l_clear_btn_selector VARCHAR2(100) := p_region.attribute_09;',
'  l_save_btn_selector  VARCHAR2(100) := p_region.attribute_10;',
'  l_alert_text         VARCHAR2(200) := p_region.attribute_11;',
'  l_show_spinner       VARCHAR2(50) := p_region.attribute_12;',
'  -- other variables',
'  l_region_id              VARCHAR2(200);',
'  l_canvas_id              VARCHAR2(200);',
'  l_background_color_esc   VARCHAR2(100);',
'  l_pen_color_esc          VARCHAR2(100);',
'  l_clear_btn_selector_esc VARCHAR2(100);',
'  l_save_btn_selector_esc  VARCHAR2(100);',
'  l_alert_text_esc         VARCHAR2(200);',
'  -- js/css file vars',
'  l_signaturepad_js  VARCHAR2(50);',
'  l_apexsignature_js VARCHAR2(50);',
'  --',
'BEGIN',
'  -- Debug',
'  IF apex_application.g_debug THEN',
'    apex_plugin_util.debug_region(p_plugin => p_plugin,',
'                                  p_region => p_region);',
'    -- set js/css filenames',
'    l_apexsignature_js := ''apexsignature'';',
'    l_signaturepad_js  := ''signature_pad'';',
'  ELSE',
'    l_apexsignature_js := ''apexsignature.min'';',
'    l_signaturepad_js  := ''signature_pad.min'';',
'  END IF;',
'  -- set variables and defaults',
'  l_region_id    := apex_escape.html_attribute(p_region.static_id ||',
'                                               ''_signature'');',
'  l_canvas_id    := l_region_id || ''_canvas'';',
'  l_logging      := nvl(l_logging,',
'                        ''false'');',
'  l_show_spinner := nvl(l_show_spinner,',
'                        ''false'');',
'  -- escape input',
'  l_background_color_esc   := sys.htf.escape_sc(l_background_color);',
'  l_pen_color_esc          := sys.htf.escape_sc(l_pen_color);',
'  l_clear_btn_selector_esc := sys.htf.escape_sc(l_clear_btn_selector);',
'  l_save_btn_selector_esc  := sys.htf.escape_sc(l_save_btn_selector);',
'  l_alert_text_esc         := sys.htf.escape_sc(l_alert_text);',
'  --',
'  -- add div and canvas for signature pad',
'  sys.htp.p(''<div id="'' || l_region_id || ''"><canvas id="'' || l_canvas_id ||',
'            ''" width="'' || l_width || ''" height="'' || l_height ||',
'            ''" style="border: solid; border-radius: 4px; box-shadow: 0 0 5px rgba(0, 0, 0, 0.02) inset;"></canvas></div>'');',
'  --',
'  -- add signaturepad and apexsignature js files',
'  apex_javascript.add_library(p_name           => l_signaturepad_js,',
'                              p_directory      => p_plugin.file_prefix ||',
'                                                  ''js/'',',
'                              p_version        => NULL,',
'                              p_skip_extension => FALSE);',
'  --',
'  apex_javascript.add_library(p_name           => l_apexsignature_js,',
'                              p_directory      => p_plugin.file_prefix ||',
'                                                  ''js/'',',
'                              p_version        => NULL,',
'                              p_skip_extension => FALSE);',
'  --',
'  -- onload code',
'  apex_javascript.add_onload_code(p_code => ''apexSignature.apexSignatureFnc('' ||',
'                                            apex_javascript.add_value(p_region.static_id) || ''{'' ||',
'                                            apex_javascript.add_attribute(''ajaxIdentifier'',',
'                                                                          apex_plugin.get_ajax_identifier) ||',
'                                            apex_javascript.add_attribute(''ajaxItemsToSubmit'',',
'                                                                          p_region.ajax_items_to_submit) ||',
'                                            apex_javascript.add_attribute(''canvasId'',',
'                                                                          l_canvas_id) ||',
'                                            apex_javascript.add_attribute(''lineMinWidth'',',
'                                                                          l_line_minwidth) ||',
'                                            apex_javascript.add_attribute(''lineMaxWidth'',',
'                                                                          l_line_maxwidth) ||',
'                                            apex_javascript.add_attribute(''backgroundColor'',',
'                                                                          l_background_color_esc) ||',
'                                            apex_javascript.add_attribute(''penColor'',',
'                                                                          l_pen_color_esc) ||',
'                                            apex_javascript.add_attribute(''clearButton'',',
'                                                                          l_clear_btn_selector_esc) ||',
'                                            apex_javascript.add_attribute(''saveButton'',',
'                                                                          l_save_btn_selector_esc) ||',
'                                            apex_javascript.add_attribute(''emptyAlert'',',
'                                                                          l_alert_text_esc) ||',
'                                            apex_javascript.add_attribute(''showSpinner'',',
'                                                                          l_show_spinner,',
'                                                                          FALSE,',
'                                                                          FALSE) || ''},'' ||',
'                                            apex_javascript.add_value(l_logging,',
'                                                                      FALSE) || '');'');',
'  --',
'  RETURN NULL;',
'  --',
'END render_apexsignature;',
'--',
'--',
'-- AJAX function',
'--',
'--',
'FUNCTION ajax_apexsignature(p_region IN apex_plugin.t_region,',
'                            p_plugin IN apex_plugin.t_plugin)',
'  RETURN apex_plugin.t_region_ajax_result IS',
'  --',
'  -- plugin attributes',
'  l_result     apex_plugin.t_region_ajax_result;',
'  l_plsql_code p_region.attribute_07%TYPE := p_region.attribute_07;',
'  --',
'BEGIN',
'  -- execute PL/SQL',
'  apex_plugin_util.execute_plsql_code(p_plsql_code => l_plsql_code);',
'  --',
'  --',
'  RETURN NULL;',
'  --',
'END ajax_apexsignature;'))
,p_api_version=>1
,p_render_function=>'render_apexsignature'
,p_ajax_function=>'ajax_apexsignature'
,p_standard_attributes=>'AJAX_ITEMS_TO_SUBMIT'
,p_substitute_attributes=>false
,p_subscribe_plugin_settings=>true
,p_help_text=>'APEX Signature allows you to draw smooth signatures into a HTML5 canvas and enables you to save the resulting image into database.'
,p_version_identifier=>'1.1'
,p_about_url=>'https://github.com/Dani3lSun/apex-plugin-apexsignature'
,p_files_version=>962
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(61329143052478421)
,p_plugin_id=>wwv_flow_api.id(61258584527411566)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_prompt=>'Width'
,p_attribute_type=>'NUMBER'
,p_is_required=>true
,p_default_value=>'600'
,p_is_translatable=>false
,p_help_text=>'Width of signature area'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(61329448809480605)
,p_plugin_id=>wwv_flow_api.id(61258584527411566)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_prompt=>'Height'
,p_attribute_type=>'NUMBER'
,p_is_required=>true
,p_default_value=>'400'
,p_is_translatable=>false
,p_help_text=>'Height of signature area'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(61329682596532743)
,p_plugin_id=>wwv_flow_api.id(61258584527411566)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>3
,p_display_sequence=>30
,p_prompt=>'Line minWidth'
,p_attribute_type=>'NUMBER'
,p_is_required=>true
,p_default_value=>'0.5'
,p_is_translatable=>false
,p_help_text=>'Minimum width of a line. Defaults to 0.5'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(61330070027535879)
,p_plugin_id=>wwv_flow_api.id(61258584527411566)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>4
,p_display_sequence=>40
,p_prompt=>'Line maxWidth'
,p_attribute_type=>'NUMBER'
,p_is_required=>true
,p_default_value=>'2.5'
,p_is_translatable=>false
,p_help_text=>'Maximum width of a line. Defaults to 2.5'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(61330282029628559)
,p_plugin_id=>wwv_flow_api.id(61258584527411566)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>5
,p_display_sequence=>50
,p_prompt=>'Background Color'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_default_value=>'rgba(0,0,0,0)'
,p_is_translatable=>false
,p_examples=>wwv_flow_string.join(wwv_flow_t_varchar2(
'rgba(0,0,0,0) - transparent black<br>',
'rgb(255,255,255) - opaque white<br>',
'#FFFFFF - white<br>',
'red'))
,p_help_text=>'Background color of signature area. Defaults to "rgba(0,0,0,0)"'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(61330615584634943)
,p_plugin_id=>wwv_flow_api.id(61258584527411566)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>6
,p_display_sequence=>60
,p_prompt=>'Pen color'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_default_value=>'black'
,p_is_translatable=>false
,p_examples=>wwv_flow_string.join(wwv_flow_t_varchar2(
'black<br>',
'#FFFFFF<br>',
'red'))
,p_help_text=>'Color used to draw the lines. Defaults to "black"'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(61331248873657961)
,p_plugin_id=>wwv_flow_api.id(61258584527411566)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>7
,p_display_sequence=>70
,p_prompt=>'PLSQL Code'
,p_attribute_type=>'PLSQL'
,p_is_required=>true
,p_default_value=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  --',
'  l_collection_name VARCHAR2(100);',
'  l_clob            CLOB;',
'  l_blob            BLOB;',
'  l_filename        VARCHAR2(100);',
'  l_mime_type       VARCHAR2(100);',
'  l_token           VARCHAR2(32000);',
'  --',
'BEGIN',
'  -- get defaults',
'  l_filename  := ''signature_'' ||',
'                 to_char(SYSDATE,',
'                         ''YYYYMMDDHH24MISS'') || ''.png'';',
'  l_mime_type := ''image/png'';',
'  -- build CLOB from f01 30k Array',
'  dbms_lob.createtemporary(l_clob,',
'                           FALSE,',
'                           dbms_lob.session);',
'',
'  FOR i IN 1 .. apex_application.g_f01.count LOOP',
'    l_token := wwv_flow.g_f01(i);',
'  ',
'    IF length(l_token) > 0 THEN',
'      dbms_lob.writeappend(l_clob,',
'                           length(l_token),',
'                           l_token);',
'    END IF;',
'  END LOOP;',
'  --',
'  -- convert base64 CLOB to BLOB (mimetype: image/png)',
'  l_blob := apex_web_service.clobbase642blob(p_clob => l_clob);',
'  --',
'  -- create own collection (here starts custom part (for example a Insert statement))',
'  -- collection name',
'  l_collection_name := ''APEX_SIGNATURE'';',
'  -- check if exist',
'  IF NOT',
'      apex_collection.collection_exists(p_collection_name => l_collection_name) THEN',
'    apex_collection.create_collection(l_collection_name);',
'  END IF;',
'  -- add collection member (only if BLOB not null)',
'  IF dbms_lob.getlength(lob_loc => l_blob) IS NOT NULL THEN',
'    apex_collection.add_member(p_collection_name => l_collection_name,',
'                               p_c001            => l_filename, -- filename',
'                               p_c002            => l_mime_type, -- mime_type',
'                               p_d001            => SYSDATE, -- date created',
'                               p_blob001         => l_blob); -- BLOB img content',
'  END IF;',
'  --',
'END;'))
,p_is_translatable=>false
,p_examples=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT c001    AS filename,<br>',
'       c002    AS mime_type,<br>',
'       d001    AS date_created,<br>',
'       blob001 AS img_content<br>',
'  FROM apex_collections<br>',
' WHERE collection_name = ''APEX_SIGNATURE'';'))
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'PLSQL code which saves the resulting image to database tables or collections.<br>',
'Default to Collection "APEX_SIGNATURE".<br>',
'Column c001 => filename<br>',
'Column c002 => mime_type<br>',
'Column d001 => date created<br>',
'Column blob001 => BLOB of image<br>'))
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(61331552030659953)
,p_plugin_id=>wwv_flow_api.id(61258584527411566)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>8
,p_display_sequence=>130
,p_prompt=>'Logging'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>false
,p_default_value=>'false'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_help_text=>'Whether to log events in the console.'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(61331844157660577)
,p_plugin_attribute_id=>wwv_flow_api.id(61331552030659953)
,p_display_sequence=>10
,p_display_value=>'True'
,p_return_value=>'true'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(61332243465661067)
,p_plugin_attribute_id=>wwv_flow_api.id(61331552030659953)
,p_display_sequence=>20
,p_display_value=>'False'
,p_return_value=>'false'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(61350117925390233)
,p_plugin_id=>wwv_flow_api.id(61258584527411566)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>9
,p_display_sequence=>90
,p_prompt=>'Clear Button JQuery Selector'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_is_translatable=>false
,p_examples=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#MY_BUTTON_STATIC_ID<br>',
'.my_button_class<br>'))
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'JQuery Selector to identify the "Clear Button" to clear signature area.<br>',
'This selector is internally used for "onclick" event.'))
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(61350751671393909)
,p_plugin_id=>wwv_flow_api.id(61258584527411566)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>10
,p_display_sequence=>100
,p_prompt=>'Save Button JQuery Selector'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_is_translatable=>false
,p_examples=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#MY_BUTTON_STATIC_ID<br>',
'.my_button_class<br>'))
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'JQuery Selector to identify the "Save Button" to save signature into Database.<br>',
'This selector is internally used for "onclick" event.'))
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(61358309035561393)
,p_plugin_id=>wwv_flow_api.id(61258584527411566)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>11
,p_display_sequence=>110
,p_prompt=>'Save empty Signature Alert text'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_default_value=>'Signature must have a value'
,p_is_translatable=>false
,p_help_text=>'Alert text when a User tries to save a empty signature.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(61379101664765769)
,p_plugin_id=>wwv_flow_api.id(61258584527411566)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>12
,p_display_sequence=>120
,p_prompt=>'Show WaitSpinner'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'false'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_help_text=>'Show/Hide wait spinner when saving image into database'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(61379709255766308)
,p_plugin_attribute_id=>wwv_flow_api.id(61379101664765769)
,p_display_sequence=>10
,p_display_value=>'True'
,p_return_value=>'true'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(61380179572766767)
,p_plugin_attribute_id=>wwv_flow_api.id(61379101664765769)
,p_display_sequence=>20
,p_display_value=>'False'
,p_return_value=>'false'
);
wwv_flow_api.create_plugin_event(
 p_id=>wwv_flow_api.id(61356724990545384)
,p_plugin_id=>wwv_flow_api.id(61258584527411566)
,p_name=>'apexsignature-cleared'
,p_display_name=>'Signature cleared'
);
wwv_flow_api.create_plugin_event(
 p_id=>wwv_flow_api.id(61357442169545385)
,p_plugin_id=>wwv_flow_api.id(61258584527411566)
,p_name=>'apexsignature-error-db'
,p_display_name=>'Signature saved to DB Error'
);
wwv_flow_api.create_plugin_event(
 p_id=>wwv_flow_api.id(61357066901545385)
,p_plugin_id=>wwv_flow_api.id(61258584527411566)
,p_name=>'apexsignature-saved-db'
,p_display_name=>'Signature saved to DB'
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '7B2276657273696F6E223A332C22736F7572636573223A5B22617065787369676E61747572652E6A73225D2C226E616D6573223A5B22617065785369676E6174757265222C227061727365426F6F6C65616E222C2270537472696E67222C2270426F6F6C';
wwv_flow_api.g_varchar2_table(2) := '65616E222C22746F4C6F77657243617365222C22756E646566696E6564222C22636C6F62324172726179222C22636C6F62222C2273697A65222C226172726179222C226C6F6F70436F756E74222C224D617468222C22666C6F6F72222C226C656E677468';
wwv_flow_api.g_varchar2_table(3) := '222C2269222C2270757368222C22736C696365222C226461746155524932626173653634222C2264617461555249222C22737562737472222C22696E6465784F66222C2273617665324462222C22704F7074696F6E73222C2270526567696F6E4964222C';
wwv_flow_api.g_varchar2_table(4) := '2270496D67222C2263616C6C6261636B222C22626173653634222C226630314172726179222C2261706578222C22736572766572222C22706C7567696E222C22616A61784964656E746966696572222C22663031222C22706167654974656D73222C2261';
wwv_flow_api.g_varchar2_table(5) := '6A61784974656D73546F5375626D6974222C2273706C6974222C226461746154797065222C2273756363657373222C2224222C2274726967676572222C226572726F72222C22786872222C22704D657373616765222C22636F6E736F6C65222C226C6F67';
wwv_flow_api.g_varchar2_table(6) := '222C22617065785369676E6174757265466E63222C22704C6F6767696E67222C22764F7074696F6E73222C227643616E76617324222C22646F63756D656E74222C22676574456C656D656E7442794964222C2263616E7661734964222C22764C6F676769';
wwv_flow_api.g_varchar2_table(7) := '6E67222C22764D696E5769647468222C227061727365496E74222C226C696E654D696E5769647468222C22764D61785769647468222C226C696E654D61785769647468222C2276436C65617242746E53656C6563746F72222C22636C656172427574746F';
wwv_flow_api.g_varchar2_table(8) := '6E222C22765361766542746E53656C6563746F72222C2273617665427574746F6E222C2276456D707479416C657274222C22656D707479416C657274222C227653686F775370696E6E6572222C2273686F775370696E6E6572222C227643616E76617357';
wwv_flow_api.g_varchar2_table(9) := '69647468222C227769647468222C227643616E766173486569676874222C22686569676874222C2276436C69656E745769647468222C22646F63756D656E74456C656D656E74222C22636C69656E745769647468222C22764369656E7448656967687422';
wwv_flow_api.g_varchar2_table(10) := '2C22636C69656E74486569676874222C226261636B67726F756E64436F6C6F72222C2270656E436F6C6F72222C227369676E6174757265506164222C225369676E6174757265506164222C226D696E5769647468222C226D61785769647468222C22636C';
wwv_flow_api.g_varchar2_table(11) := '69636B222C22636C656172222C226973456D707479222C226C5370696E6E657224222C227574696C222C2276496D67222C22746F4461746155524C222C2272656D6F7665222C22616C657274225D2C226D617070696E6773223A2241414B412C49414149';
wwv_flow_api.g_varchar2_table(12) := '412C63414167422C4341456842432C614141632C53414153432C4741436E422C49414149432C4541554A2C4D415436422C5141417A42442C45414151452C6742414352442C474141572C474145632C5341417A42442C45414151452C6742414352442C47';
wwv_flow_api.g_varchar2_table(13) := '4141572C47414567422C5141417A42442C45414151452C65414175442C5341417A42462C45414151452C674241436844442C4F414157452C47414552462C47414758472C574141592C53414153432C4541414D432C4541414D432C4741433742432C5541';
wwv_flow_api.g_varchar2_table(14) := '4159432C4B41414B432C4D41414D4C2C4541414B4D2C4F4141534C2C474141512C45414337432C4941414B2C494141494D2C454141492C45414147412C454141494A2C55414157492C49414333424C2C4541414D4D2C4B41414B522C4541414B532C4D41';
wwv_flow_api.g_varchar2_table(15) := '414D522C4541414F4D2C454141474E2C474141514D2C454141492C4B414568442C4F41414F4C2C47414758512C65414167422C53414153432C47414572422C4F414461412C45414151432C4F41414F442C45414151452C514141512C4B41414F2C494149';
wwv_flow_api.g_varchar2_table(16) := '7644432C514141532C53414153432C45414155432C45414157432C4541414D432C4741457A432C49414149432C4541415331422C6341416369422C654141654F2C4741457443472C454141572C47414366412C4541415733422C634141634D2C57414157';
wwv_flow_api.g_varchar2_table(17) := '6F422C454141512C4941414F432C4741456E44432C4B41414B432C4F41414F432C4F41414F522C45414153532C65414167422C4341437843432C4941414B4C2C4541454C4D2C55414157582C45414153592C6B4241416B42432C4D41414D2C4D41433743';
wwv_flow_api.g_varchar2_table(18) := '2C43414343432C534141552C4F414556432C514141532C5741454C432C454141452C4941414D662C4741415767422C514141512C304241453342642C4B41474A652C4D41414F2C53414153432C4541414B432C4741456A424A2C454141452C4941414D66';
wwv_flow_api.g_varchar2_table(19) := '2C4741415767422C514141512C304241433342492C51414151432C494141492C714341417343462C4741456C446A422C51414B5A6F422C694241416B422C5341415374422C45414157442C4541415577422C47414335432C49414149432C454141577A42';
wwv_flow_api.g_varchar2_table(20) := '2C4541435830422C45414157432C53414153432C65414165482C45414153492C5541433543432C4541415770442C63414163432C6141416136432C47414374434F2C45414159432C53414153502C45414153512C6341433942432C45414159462C534141';
wwv_flow_api.g_varchar2_table(21) := '53502C45414153552C6341433942432C4541416F42582C45414153592C5941433742432C4541416D42622C45414153632C5741433542432C45414163662C4541415367422C5741437642432C4541416568452C63414163432C6141416138432C45414153';
wwv_flow_api.g_varchar2_table(22) := '6B422C6141436E44432C454141656C422C454141536D422C4D41437842432C454141674270422C4541415371422C4F41437A42432C4541416568422C534141534C2C5341415373422C674241416742432C6141436A44432C454141656E422C534141534C';
wwv_flow_api.g_varchar2_table(23) := '2C5341415373422C674241416742472C6341456A4474422C49414341542C51414151432C494141492C364341413843472C4541415368422C674241436E45592C51414151432C494141492C674441416944472C45414153622C6D4241437445532C514141';
wwv_flow_api.g_varchar2_table(24) := '51432C494141492C754341417743472C45414153492C5541433744522C51414151432C494141492C324341413443472C45414153512C6341436A455A2C51414151432C494141492C324341413443472C45414153552C6341436A45642C51414151432C49';
wwv_flow_api.g_varchar2_table(25) := '4141492C384341412B43472C4541415334422C69424143704568432C51414151432C494141492C754341417743472C4541415336422C55414337446A432C51414151432C494141492C794341413043472C45414153632C5941432F446C422C5141415143';
wwv_flow_api.g_varchar2_table(26) := '2C494141492C304341413243472C45414153592C614143684568422C51414151432C494141492C794341413043472C4541415367422C5941432F4470422C51414151432C494141492C304341413243472C454141536B422C614143684574422C51414151';
wwv_flow_api.g_varchar2_table(27) := '432C494141492C2B424141674372422C47414335436F422C51414151432C494141492C6B4341416D4373422C4741432F4376422C51414151432C494141492C6D4341416F4377422C47414368447A422C51414151432C494141492C6B4341416D4330422C';
wwv_flow_api.g_varchar2_table(28) := '4741432F4333422C51414151432C494141492C6B4341416D4377422C4941472F43462C45414165492C4941436674422C454141536D422C4D414151472C454141652C4941456843462C45414167424B2C49414368427A422C4541415371422C4F41415349';
wwv_flow_api.g_varchar2_table(29) := '2C454141652C49414972432C49414149492C454141652C49414149432C6141416139422C454141552C43414331432B422C5341415531422C4541435632422C5341415578422C454143566D422C67424141694235422C4541415334422C67424143314243';
wwv_flow_api.g_varchar2_table(30) := '2C5341415537422C4541415336422C574147764274432C454141456F422C4741416D4275422C4F41414D2C57414376424A2C454141614B2C5141456235432C454141452C4941414D662C4741415767422C514141512C344241472F42442C454141457342';
wwv_flow_api.g_varchar2_table(31) := '2C4741416B4271422C4F41414D2C57414774422C49414169422C494146464A2C454141614D2C5541454A2C43414570422C474141496E422C454143412C494141496F422C4541415978442C4B41414B79442C4B41414B70422C5941415933422C45414145';
wwv_flow_api.g_varchar2_table(32) := '2C4941414D662C4941476C442C494141492B442C4541414F542C45414161552C594143784276462C6341416371422C5141415130422C4541415578422C454141572B442C4741414D2C5741453743542C454141614B2C514145546C422C474143416F422C';
wwv_flow_api.g_varchar2_table(33) := '45414155492C6942414B6C42432C4D41414D3342222C2266696C65223A22617065787369676E61747572652E6A73227D';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(12872091438161356)
,p_plugin_id=>wwv_flow_api.id(61258584527411566)
,p_file_name=>'js/apexsignature.js.map'
,p_mime_type=>'application/json'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '2866756E6374696F6E2028726F6F742C20666163746F727929207B0A202069662028747970656F6620646566696E65203D3D3D202766756E6374696F6E2720262620646566696E652E616D6429207B0A202020202F2F20414D442E205265676973746572';
wwv_flow_api.g_varchar2_table(2) := '20617320616E20616E6F6E796D6F7573206D6F64756C6520756E6C65737320616D644D6F64756C654964206973207365740A20202020646566696E65285B5D2C2066756E6374696F6E202829207B0A20202020202072657475726E2028726F6F745B2753';
wwv_flow_api.g_varchar2_table(3) := '69676E6174757265506164275D203D20666163746F72792829293B0A202020207D293B0A20207D20656C73652069662028747970656F66206578706F727473203D3D3D20276F626A6563742729207B0A202020202F2F204E6F64652E20446F6573206E6F';
wwv_flow_api.g_varchar2_table(4) := '7420776F726B20776974682073747269637420436F6D6D6F6E4A532C206275740A202020202F2F206F6E6C7920436F6D6D6F6E4A532D6C696B6520656E7669726F6E6D656E7473207468617420737570706F7274206D6F64756C652E6578706F7274732C';
wwv_flow_api.g_varchar2_table(5) := '0A202020202F2F206C696B65204E6F64652E0A202020206D6F64756C652E6578706F727473203D20666163746F727928293B0A20207D20656C7365207B0A20202020726F6F745B275369676E6174757265506164275D203D20666163746F727928293B0A';
wwv_flow_api.g_varchar2_table(6) := '20207D0A7D28746869732C2066756E6374696F6E202829207B0A0A2F2A210A202A205369676E6174757265205061642076312E352E330A202A2068747470733A2F2F6769746875622E636F6D2F737A696D656B2F7369676E61747572655F7061640A202A';
wwv_flow_api.g_varchar2_table(7) := '0A202A20436F70797269676874203230313620537A796D6F6E204E6F77616B0A202A2052656C656173656420756E64657220746865204D4954206C6963656E73650A202A0A202A20546865206D61696E206964656120616E6420736F6D65207061727473';
wwv_flow_api.g_varchar2_table(8) := '206F662074686520636F64652028652E672E2064726177696E67207661726961626C652077696474682042C3A97A69657220637572766529206172652074616B656E2066726F6D3A0A202A20687474703A2F2F636F726E65722E73717561726575702E63';
wwv_flow_api.g_varchar2_table(9) := '6F6D2F323031322F30372F736D6F6F746865722D7369676E6174757265732E68746D6C0A202A0A202A20496D706C656D656E746174696F6E206F6620696E746572706F6C6174696F6E207573696E672063756269632042C3A97A69657220637572766573';
wwv_flow_api.g_varchar2_table(10) := '2069732074616B656E2066726F6D3A0A202A20687474703A2F2F62656E6B6E6F7773636F64652E776F726470726573732E636F6D2F323031322F30392F31342F706174682D696E746572706F6C6174696F6E2D7573696E672D63756269632D62657A6965';
wwv_flow_api.g_varchar2_table(11) := '722D616E642D636F6E74726F6C2D706F696E742D657374696D6174696F6E2D696E2D6A6176617363726970740A202A0A202A20416C676F726974686D20666F7220617070726F78696D61746564206C656E677468206F6620612042C3A97A696572206375';
wwv_flow_api.g_varchar2_table(12) := '7276652069732074616B656E2066726F6D3A0A202A20687474703A2F2F7777772E6C656D6F64612E6E65742F6D617468732F62657A6965722D6C656E6774682F696E6465782E68746D6C0A202A0A202A2F0A766172205369676E6174757265506164203D';
wwv_flow_api.g_varchar2_table(13) := '202866756E6374696F6E2028646F63756D656E7429207B0A202020202275736520737472696374223B0A0A20202020766172205369676E6174757265506164203D2066756E6374696F6E202863616E7661732C206F7074696F6E7329207B0A2020202020';
wwv_flow_api.g_varchar2_table(14) := '2020207661722073656C66203D20746869732C0A2020202020202020202020206F707473203D206F7074696F6E73207C7C207B7D3B0A0A2020202020202020746869732E76656C6F6369747946696C746572576569676874203D206F7074732E76656C6F';
wwv_flow_api.g_varchar2_table(15) := '6369747946696C746572576569676874207C7C20302E373B0A2020202020202020746869732E6D696E5769647468203D206F7074732E6D696E5769647468207C7C20302E353B0A2020202020202020746869732E6D61785769647468203D206F7074732E';
wwv_flow_api.g_varchar2_table(16) := '6D61785769647468207C7C20322E353B0A2020202020202020746869732E646F7453697A65203D206F7074732E646F7453697A65207C7C2066756E6374696F6E202829207B0A20202020202020202020202072657475726E2028746869732E6D696E5769';
wwv_flow_api.g_varchar2_table(17) := '647468202B20746869732E6D6178576964746829202F20323B0A20202020202020207D3B0A2020202020202020746869732E70656E436F6C6F72203D206F7074732E70656E436F6C6F72207C7C2022626C61636B223B0A2020202020202020746869732E';
wwv_flow_api.g_varchar2_table(18) := '6261636B67726F756E64436F6C6F72203D206F7074732E6261636B67726F756E64436F6C6F72207C7C20227267626128302C302C302C3029223B0A2020202020202020746869732E6F6E456E64203D206F7074732E6F6E456E643B0A2020202020202020';
wwv_flow_api.g_varchar2_table(19) := '746869732E6F6E426567696E203D206F7074732E6F6E426567696E3B0A0A2020202020202020746869732E5F63616E766173203D2063616E7661733B0A2020202020202020746869732E5F637478203D2063616E7661732E676574436F6E746578742822';
wwv_flow_api.g_varchar2_table(20) := '326422293B0A2020202020202020746869732E636C65617228293B0A0A20202020202020202F2F207765206E6565642061646420746865736520696E6C696E6520736F20746865792061726520617661696C61626C6520746F20756E62696E6420776869';
wwv_flow_api.g_varchar2_table(21) := '6C65207374696C6C20686176696E670A20202020202020202F2F202061636365737320746F202773656C662720776520636F756C6420757365205F2E62696E64206275742069742773206E6F7420776F72746820616464696E67206120646570656E6465';
wwv_flow_api.g_varchar2_table(22) := '6E63790A2020202020202020746869732E5F68616E646C654D6F757365446F776E203D2066756E6374696F6E20286576656E7429207B0A202020202020202020202020696620286576656E742E7768696368203D3D3D203129207B0A2020202020202020';
wwv_flow_api.g_varchar2_table(23) := '202020202020202073656C662E5F6D6F757365427574746F6E446F776E203D20747275653B0A2020202020202020202020202020202073656C662E5F7374726F6B65426567696E286576656E74293B0A2020202020202020202020207D0A202020202020';
wwv_flow_api.g_varchar2_table(24) := '20207D3B0A0A2020202020202020746869732E5F68616E646C654D6F7573654D6F7665203D2066756E6374696F6E20286576656E7429207B0A2020202020202020202020206966202873656C662E5F6D6F757365427574746F6E446F776E29207B0A2020';
wwv_flow_api.g_varchar2_table(25) := '202020202020202020202020202073656C662E5F7374726F6B65557064617465286576656E74293B0A2020202020202020202020207D0A20202020202020207D3B0A0A2020202020202020746869732E5F68616E646C654D6F7573655570203D2066756E';
wwv_flow_api.g_varchar2_table(26) := '6374696F6E20286576656E7429207B0A202020202020202020202020696620286576656E742E7768696368203D3D3D20312026262073656C662E5F6D6F757365427574746F6E446F776E29207B0A2020202020202020202020202020202073656C662E5F';
wwv_flow_api.g_varchar2_table(27) := '6D6F757365427574746F6E446F776E203D2066616C73653B0A2020202020202020202020202020202073656C662E5F7374726F6B65456E64286576656E74293B0A2020202020202020202020207D0A20202020202020207D3B0A0A202020202020202074';
wwv_flow_api.g_varchar2_table(28) := '6869732E5F68616E646C65546F7563685374617274203D2066756E6374696F6E20286576656E7429207B0A202020202020202020202020696620286576656E742E746172676574546F75636865732E6C656E677468203D3D203129207B0A202020202020';
wwv_flow_api.g_varchar2_table(29) := '2020202020202020202076617220746F756368203D206576656E742E6368616E676564546F75636865735B305D3B0A2020202020202020202020202020202073656C662E5F7374726F6B65426567696E28746F756368293B0A2020202020202020202020';
wwv_flow_api.g_varchar2_table(30) := '20207D0A20202020202020207D3B0A0A2020202020202020746869732E5F68616E646C65546F7563684D6F7665203D2066756E6374696F6E20286576656E7429207B0A2020202020202020202020202F2F2050726576656E74207363726F6C6C696E672E';
wwv_flow_api.g_varchar2_table(31) := '0A2020202020202020202020206576656E742E70726576656E7444656661756C7428293B0A0A20202020202020202020202076617220746F756368203D206576656E742E746172676574546F75636865735B305D3B0A2020202020202020202020207365';
wwv_flow_api.g_varchar2_table(32) := '6C662E5F7374726F6B6555706461746528746F756368293B0A20202020202020207D3B0A0A2020202020202020746869732E5F68616E646C65546F756368456E64203D2066756E6374696F6E20286576656E7429207B0A20202020202020202020202076';
wwv_flow_api.g_varchar2_table(33) := '61722077617343616E766173546F7563686564203D206576656E742E746172676574203D3D3D2073656C662E5F63616E7661733B0A2020202020202020202020206966202877617343616E766173546F756368656429207B0A2020202020202020202020';
wwv_flow_api.g_varchar2_table(34) := '20202020206576656E742E70726576656E7444656661756C7428293B0A2020202020202020202020202020202073656C662E5F7374726F6B65456E64286576656E74293B0A2020202020202020202020207D0A20202020202020207D3B0A0A2020202020';
wwv_flow_api.g_varchar2_table(35) := '202020746869732E5F68616E646C654D6F7573654576656E747328293B0A2020202020202020746869732E5F68616E646C65546F7563684576656E747328293B0A202020207D3B0A0A202020205369676E61747572655061642E70726F746F747970652E';
wwv_flow_api.g_varchar2_table(36) := '636C656172203D2066756E6374696F6E202829207B0A202020202020202076617220637478203D20746869732E5F6374782C0A20202020202020202020202063616E766173203D20746869732E5F63616E7661733B0A0A20202020202020206374782E66';
wwv_flow_api.g_varchar2_table(37) := '696C6C5374796C65203D20746869732E6261636B67726F756E64436F6C6F723B0A20202020202020206374782E636C6561725265637428302C20302C2063616E7661732E77696474682C2063616E7661732E686569676874293B0A202020202020202063';
wwv_flow_api.g_varchar2_table(38) := '74782E66696C6C5265637428302C20302C2063616E7661732E77696474682C2063616E7661732E686569676874293B0A2020202020202020746869732E5F726573657428293B0A202020207D3B0A0A202020205369676E61747572655061642E70726F74';
wwv_flow_api.g_varchar2_table(39) := '6F747970652E746F4461746155524C203D2066756E6374696F6E2028696D616765547970652C207175616C69747929207B0A20202020202020207661722063616E766173203D20746869732E5F63616E7661733B0A202020202020202072657475726E20';
wwv_flow_api.g_varchar2_table(40) := '63616E7661732E746F4461746155524C2E6170706C792863616E7661732C20617267756D656E7473293B0A202020207D3B0A0A202020205369676E61747572655061642E70726F746F747970652E66726F6D4461746155524C203D2066756E6374696F6E';
wwv_flow_api.g_varchar2_table(41) := '20286461746155726C29207B0A20202020202020207661722073656C66203D20746869732C0A202020202020202020202020696D616765203D206E657720496D61676528292C0A202020202020202020202020726174696F203D2077696E646F772E6465';
wwv_flow_api.g_varchar2_table(42) := '76696365506978656C526174696F207C7C20312C0A2020202020202020202020207769647468203D20746869732E5F63616E7661732E7769647468202F20726174696F2C0A202020202020202020202020686569676874203D20746869732E5F63616E76';
wwv_flow_api.g_varchar2_table(43) := '61732E686569676874202F20726174696F3B0A0A2020202020202020746869732E5F726573657428293B0A2020202020202020696D6167652E737263203D206461746155726C3B0A2020202020202020696D6167652E6F6E6C6F6164203D2066756E6374';
wwv_flow_api.g_varchar2_table(44) := '696F6E202829207B0A20202020202020202020202073656C662E5F6374782E64726177496D61676528696D6167652C20302C20302C2077696474682C20686569676874293B0A20202020202020207D3B0A2020202020202020746869732E5F6973456D70';
wwv_flow_api.g_varchar2_table(45) := '7479203D2066616C73653B0A202020207D3B0A0A202020205369676E61747572655061642E70726F746F747970652E5F7374726F6B65557064617465203D2066756E6374696F6E20286576656E7429207B0A202020202020202076617220706F696E7420';
wwv_flow_api.g_varchar2_table(46) := '3D20746869732E5F637265617465506F696E74286576656E74293B0A2020202020202020746869732E5F616464506F696E7428706F696E74293B0A202020207D3B0A0A202020205369676E61747572655061642E70726F746F747970652E5F7374726F6B';
wwv_flow_api.g_varchar2_table(47) := '65426567696E203D2066756E6374696F6E20286576656E7429207B0A2020202020202020746869732E5F726573657428293B0A2020202020202020746869732E5F7374726F6B65557064617465286576656E74293B0A2020202020202020696620287479';
wwv_flow_api.g_varchar2_table(48) := '70656F6620746869732E6F6E426567696E203D3D3D202766756E6374696F6E2729207B0A202020202020202020202020746869732E6F6E426567696E286576656E74293B0A20202020202020207D0A202020207D3B0A0A202020205369676E6174757265';
wwv_flow_api.g_varchar2_table(49) := '5061642E70726F746F747970652E5F7374726F6B6544726177203D2066756E6374696F6E2028706F696E7429207B0A202020202020202076617220637478203D20746869732E5F6374782C0A202020202020202020202020646F7453697A65203D207479';
wwv_flow_api.g_varchar2_table(50) := '70656F6628746869732E646F7453697A6529203D3D3D202766756E6374696F6E27203F20746869732E646F7453697A652829203A20746869732E646F7453697A653B0A0A20202020202020206374782E626567696E5061746828293B0A20202020202020';
wwv_flow_api.g_varchar2_table(51) := '20746869732E5F64726177506F696E7428706F696E742E782C20706F696E742E792C20646F7453697A65293B0A20202020202020206374782E636C6F73655061746828293B0A20202020202020206374782E66696C6C28293B0A202020207D3B0A0A2020';
wwv_flow_api.g_varchar2_table(52) := '20205369676E61747572655061642E70726F746F747970652E5F7374726F6B65456E64203D2066756E6374696F6E20286576656E7429207B0A20202020202020207661722063616E447261774375727665203D20746869732E706F696E74732E6C656E67';
wwv_flow_api.g_varchar2_table(53) := '7468203E20322C0A202020202020202020202020706F696E74203D20746869732E706F696E74735B305D3B0A0A2020202020202020696620282163616E44726177437572766520262620706F696E7429207B0A202020202020202020202020746869732E';
wwv_flow_api.g_varchar2_table(54) := '5F7374726F6B654472617728706F696E74293B0A20202020202020207D0A202020202020202069662028747970656F6620746869732E6F6E456E64203D3D3D202766756E6374696F6E2729207B0A202020202020202020202020746869732E6F6E456E64';
wwv_flow_api.g_varchar2_table(55) := '286576656E74293B0A20202020202020207D0A202020207D3B0A0A202020205369676E61747572655061642E70726F746F747970652E5F68616E646C654D6F7573654576656E7473203D2066756E6374696F6E202829207B0A2020202020202020746869';
wwv_flow_api.g_varchar2_table(56) := '732E5F6D6F757365427574746F6E446F776E203D2066616C73653B0A0A2020202020202020746869732E5F63616E7661732E6164644576656E744C697374656E657228226D6F757365646F776E222C20746869732E5F68616E646C654D6F757365446F77';
wwv_flow_api.g_varchar2_table(57) := '6E293B0A2020202020202020746869732E5F63616E7661732E6164644576656E744C697374656E657228226D6F7573656D6F7665222C20746869732E5F68616E646C654D6F7573654D6F7665293B0A2020202020202020646F63756D656E742E61646445';
wwv_flow_api.g_varchar2_table(58) := '76656E744C697374656E657228226D6F7573657570222C20746869732E5F68616E646C654D6F7573655570293B0A202020207D3B0A0A202020205369676E61747572655061642E70726F746F747970652E5F68616E646C65546F7563684576656E747320';
wwv_flow_api.g_varchar2_table(59) := '3D2066756E6374696F6E202829207B0A20202020202020202F2F205061737320746F756368206576656E747320746F2063616E76617320656C656D656E74206F6E206D6F62696C65204945313120616E6420456467652E0A202020202020202074686973';
wwv_flow_api.g_varchar2_table(60) := '2E5F63616E7661732E7374796C652E6D73546F756368416374696F6E203D20276E6F6E65273B0A2020202020202020746869732E5F63616E7661732E7374796C652E746F756368416374696F6E203D20276E6F6E65273B0A0A2020202020202020746869';
wwv_flow_api.g_varchar2_table(61) := '732E5F63616E7661732E6164644576656E744C697374656E65722822746F7563687374617274222C20746869732E5F68616E646C65546F7563685374617274293B0A2020202020202020746869732E5F63616E7661732E6164644576656E744C69737465';
wwv_flow_api.g_varchar2_table(62) := '6E65722822746F7563686D6F7665222C20746869732E5F68616E646C65546F7563684D6F7665293B0A2020202020202020746869732E5F63616E7661732E6164644576656E744C697374656E65722822746F756368656E64222C20746869732E5F68616E';
wwv_flow_api.g_varchar2_table(63) := '646C65546F756368456E64293B0A202020207D3B0A0A202020205369676E61747572655061642E70726F746F747970652E6F6E203D2066756E6374696F6E202829207B0A2020202020202020746869732E5F68616E646C654D6F7573654576656E747328';
wwv_flow_api.g_varchar2_table(64) := '293B0A2020202020202020746869732E5F68616E646C65546F7563684576656E747328293B0A202020207D3B0A0A202020205369676E61747572655061642E70726F746F747970652E6F6666203D2066756E6374696F6E202829207B0A20202020202020';
wwv_flow_api.g_varchar2_table(65) := '20746869732E5F63616E7661732E72656D6F76654576656E744C697374656E657228226D6F757365646F776E222C20746869732E5F68616E646C654D6F757365446F776E293B0A2020202020202020746869732E5F63616E7661732E72656D6F76654576';
wwv_flow_api.g_varchar2_table(66) := '656E744C697374656E657228226D6F7573656D6F7665222C20746869732E5F68616E646C654D6F7573654D6F7665293B0A2020202020202020646F63756D656E742E72656D6F76654576656E744C697374656E657228226D6F7573657570222C20746869';
wwv_flow_api.g_varchar2_table(67) := '732E5F68616E646C654D6F7573655570293B0A0A2020202020202020746869732E5F63616E7661732E72656D6F76654576656E744C697374656E65722822746F7563687374617274222C20746869732E5F68616E646C65546F7563685374617274293B0A';
wwv_flow_api.g_varchar2_table(68) := '2020202020202020746869732E5F63616E7661732E72656D6F76654576656E744C697374656E65722822746F7563686D6F7665222C20746869732E5F68616E646C65546F7563684D6F7665293B0A2020202020202020746869732E5F63616E7661732E72';
wwv_flow_api.g_varchar2_table(69) := '656D6F76654576656E744C697374656E65722822746F756368656E64222C20746869732E5F68616E646C65546F756368456E64293B0A202020207D3B0A0A202020205369676E61747572655061642E70726F746F747970652E6973456D707479203D2066';
wwv_flow_api.g_varchar2_table(70) := '756E6374696F6E202829207B0A202020202020202072657475726E20746869732E5F6973456D7074793B0A202020207D3B0A0A202020205369676E61747572655061642E70726F746F747970652E5F7265736574203D2066756E6374696F6E202829207B';
wwv_flow_api.g_varchar2_table(71) := '0A2020202020202020746869732E706F696E7473203D205B5D3B0A2020202020202020746869732E5F6C61737456656C6F63697479203D20303B0A2020202020202020746869732E5F6C6173745769647468203D2028746869732E6D696E576964746820';
wwv_flow_api.g_varchar2_table(72) := '2B20746869732E6D6178576964746829202F20323B0A2020202020202020746869732E5F6973456D707479203D20747275653B0A2020202020202020746869732E5F6374782E66696C6C5374796C65203D20746869732E70656E436F6C6F723B0A202020';
wwv_flow_api.g_varchar2_table(73) := '207D3B0A0A202020205369676E61747572655061642E70726F746F747970652E5F637265617465506F696E74203D2066756E6374696F6E20286576656E7429207B0A20202020202020207661722072656374203D20746869732E5F63616E7661732E6765';
wwv_flow_api.g_varchar2_table(74) := '74426F756E64696E67436C69656E745265637428293B0A202020202020202072657475726E206E657720506F696E74280A2020202020202020202020206576656E742E636C69656E7458202D20726563742E6C6566742C0A202020202020202020202020';
wwv_flow_api.g_varchar2_table(75) := '6576656E742E636C69656E7459202D20726563742E746F700A2020202020202020293B0A202020207D3B0A0A202020205369676E61747572655061642E70726F746F747970652E5F616464506F696E74203D2066756E6374696F6E2028706F696E742920';
wwv_flow_api.g_varchar2_table(76) := '7B0A202020202020202076617220706F696E7473203D20746869732E706F696E74732C0A20202020202020202020202063322C2063332C0A20202020202020202020202063757276652C20746D703B0A0A2020202020202020706F696E74732E70757368';
wwv_flow_api.g_varchar2_table(77) := '28706F696E74293B0A0A202020202020202069662028706F696E74732E6C656E677468203E203229207B0A2020202020202020202020202F2F20546F207265647563652074686520696E697469616C206C6167206D616B6520697420776F726B20776974';
wwv_flow_api.g_varchar2_table(78) := '68203320706F696E74730A2020202020202020202020202F2F20627920636F7079696E672074686520666972737420706F696E7420746F2074686520626567696E6E696E672E0A20202020202020202020202069662028706F696E74732E6C656E677468';
wwv_flow_api.g_varchar2_table(79) := '203D3D3D20332920706F696E74732E756E736869667428706F696E74735B305D293B0A0A202020202020202020202020746D70203D20746869732E5F63616C63756C6174654375727665436F6E74726F6C506F696E747328706F696E74735B305D2C2070';
wwv_flow_api.g_varchar2_table(80) := '6F696E74735B315D2C20706F696E74735B325D293B0A2020202020202020202020206332203D20746D702E63323B0A202020202020202020202020746D70203D20746869732E5F63616C63756C6174654375727665436F6E74726F6C506F696E74732870';
wwv_flow_api.g_varchar2_table(81) := '6F696E74735B315D2C20706F696E74735B325D2C20706F696E74735B335D293B0A2020202020202020202020206333203D20746D702E63313B0A2020202020202020202020206375727665203D206E65772042657A69657228706F696E74735B315D2C20';
wwv_flow_api.g_varchar2_table(82) := '63322C2063332C20706F696E74735B325D293B0A202020202020202020202020746869732E5F6164644375727665286375727665293B0A0A2020202020202020202020202F2F2052656D6F76652074686520666972737420656C656D656E742066726F6D';
wwv_flow_api.g_varchar2_table(83) := '20746865206C6973742C0A2020202020202020202020202F2F20736F207468617420776520616C776179732068617665206E6F206D6F7265207468616E203420706F696E747320696E20706F696E74732061727261792E0A202020202020202020202020';
wwv_flow_api.g_varchar2_table(84) := '706F696E74732E736869667428293B0A20202020202020207D0A202020207D3B0A0A202020205369676E61747572655061642E70726F746F747970652E5F63616C63756C6174654375727665436F6E74726F6C506F696E7473203D2066756E6374696F6E';
wwv_flow_api.g_varchar2_table(85) := '202873312C2073322C20733329207B0A202020202020202076617220647831203D2073312E78202D2073322E782C20647931203D2073312E79202D2073322E792C0A202020202020202020202020647832203D2073322E78202D2073332E782C20647932';
wwv_flow_api.g_varchar2_table(86) := '203D2073322E79202D2073332E792C0A0A2020202020202020202020206D31203D207B783A202873312E78202B2073322E7829202F20322E302C20793A202873312E79202B2073322E7929202F20322E307D2C0A2020202020202020202020206D32203D';
wwv_flow_api.g_varchar2_table(87) := '207B783A202873322E78202B2073332E7829202F20322E302C20793A202873322E79202B2073332E7929202F20322E307D2C0A0A2020202020202020202020206C31203D204D6174682E73717274286478312A647831202B206479312A647931292C0A20';
wwv_flow_api.g_varchar2_table(88) := '20202020202020202020206C32203D204D6174682E73717274286478322A647832202B206479322A647932292C0A0A20202020202020202020202064786D203D20286D312E78202D206D322E78292C0A20202020202020202020202064796D203D20286D';
wwv_flow_api.g_varchar2_table(89) := '312E79202D206D322E79292C0A0A2020202020202020202020206B203D206C32202F20286C31202B206C32292C0A202020202020202020202020636D203D207B783A206D322E78202B2064786D2A6B2C20793A206D322E79202B2064796D2A6B7D2C0A0A';
wwv_flow_api.g_varchar2_table(90) := '2020202020202020202020207478203D2073322E78202D20636D2E782C0A2020202020202020202020207479203D2073322E79202D20636D2E793B0A0A202020202020202072657475726E207B0A20202020202020202020202063313A206E657720506F';
wwv_flow_api.g_varchar2_table(91) := '696E74286D312E78202B2074782C206D312E79202B207479292C0A20202020202020202020202063323A206E657720506F696E74286D322E78202B2074782C206D322E79202B207479290A20202020202020207D3B0A202020207D3B0A0A202020205369';
wwv_flow_api.g_varchar2_table(92) := '676E61747572655061642E70726F746F747970652E5F6164644375727665203D2066756E6374696F6E2028637572766529207B0A2020202020202020766172207374617274506F696E74203D2063757276652E7374617274506F696E742C0A2020202020';
wwv_flow_api.g_varchar2_table(93) := '20202020202020656E64506F696E74203D2063757276652E656E64506F696E742C0A20202020202020202020202076656C6F636974792C206E657757696474683B0A0A202020202020202076656C6F63697479203D20656E64506F696E742E76656C6F63';
wwv_flow_api.g_varchar2_table(94) := '69747946726F6D287374617274506F696E74293B0A202020202020202076656C6F63697479203D20746869732E76656C6F6369747946696C746572576569676874202A2076656C6F636974790A2020202020202020202020202B202831202D2074686973';
wwv_flow_api.g_varchar2_table(95) := '2E76656C6F6369747946696C74657257656967687429202A20746869732E5F6C61737456656C6F636974793B0A0A20202020202020206E65775769647468203D20746869732E5F7374726F6B6557696474682876656C6F63697479293B0A202020202020';
wwv_flow_api.g_varchar2_table(96) := '2020746869732E5F6472617743757276652863757276652C20746869732E5F6C61737457696474682C206E65775769647468293B0A0A2020202020202020746869732E5F6C61737456656C6F63697479203D2076656C6F636974793B0A20202020202020';
wwv_flow_api.g_varchar2_table(97) := '20746869732E5F6C6173745769647468203D206E657757696474683B0A202020207D3B0A0A202020205369676E61747572655061642E70726F746F747970652E5F64726177506F696E74203D2066756E6374696F6E2028782C20792C2073697A6529207B';
wwv_flow_api.g_varchar2_table(98) := '0A202020202020202076617220637478203D20746869732E5F6374783B0A0A20202020202020206374782E6D6F7665546F28782C2079293B0A20202020202020206374782E61726328782C20792C2073697A652C20302C2032202A204D6174682E50492C';
wwv_flow_api.g_varchar2_table(99) := '2066616C7365293B0A2020202020202020746869732E5F6973456D707479203D2066616C73653B0A202020207D3B0A0A202020205369676E61747572655061642E70726F746F747970652E5F647261774375727665203D2066756E6374696F6E20286375';
wwv_flow_api.g_varchar2_table(100) := '7276652C20737461727457696474682C20656E64576964746829207B0A202020202020202076617220637478203D20746869732E5F6374782C0A202020202020202020202020776964746844656C7461203D20656E645769647468202D20737461727457';
wwv_flow_api.g_varchar2_table(101) := '696474682C0A2020202020202020202020206472617753746570732C2077696474682C20692C20742C2074742C207474742C20752C2075752C207575752C20782C20793B0A0A2020202020202020647261775374657073203D204D6174682E666C6F6F72';
wwv_flow_api.g_varchar2_table(102) := '2863757276652E6C656E6774682829293B0A20202020202020206374782E626567696E5061746828293B0A2020202020202020666F72202869203D20303B2069203C206472617753746570733B20692B2B29207B0A2020202020202020202020202F2F20';
wwv_flow_api.g_varchar2_table(103) := '43616C63756C617465207468652042657A6965722028782C20792920636F6F7264696E61746520666F72207468697320737465702E0A20202020202020202020202074203D2069202F206472617753746570733B0A202020202020202020202020747420';
wwv_flow_api.g_varchar2_table(104) := '3D2074202A20743B0A202020202020202020202020747474203D207474202A20743B0A20202020202020202020202075203D2031202D20743B0A2020202020202020202020207575203D2075202A20753B0A202020202020202020202020757575203D20';
wwv_flow_api.g_varchar2_table(105) := '7575202A20753B0A0A20202020202020202020202078203D20757575202A2063757276652E7374617274506F696E742E783B0A20202020202020202020202078202B3D2033202A207575202A2074202A2063757276652E636F6E74726F6C312E783B0A20';
wwv_flow_api.g_varchar2_table(106) := '202020202020202020202078202B3D2033202A2075202A207474202A2063757276652E636F6E74726F6C322E783B0A20202020202020202020202078202B3D20747474202A2063757276652E656E64506F696E742E783B0A0A2020202020202020202020';
wwv_flow_api.g_varchar2_table(107) := '2079203D20757575202A2063757276652E7374617274506F696E742E793B0A20202020202020202020202079202B3D2033202A207575202A2074202A2063757276652E636F6E74726F6C312E793B0A20202020202020202020202079202B3D2033202A20';
wwv_flow_api.g_varchar2_table(108) := '75202A207474202A2063757276652E636F6E74726F6C322E793B0A20202020202020202020202079202B3D20747474202A2063757276652E656E64506F696E742E793B0A0A2020202020202020202020207769647468203D207374617274576964746820';
wwv_flow_api.g_varchar2_table(109) := '2B20747474202A20776964746844656C74613B0A202020202020202020202020746869732E5F64726177506F696E7428782C20792C207769647468293B0A20202020202020207D0A20202020202020206374782E636C6F73655061746828293B0A202020';
wwv_flow_api.g_varchar2_table(110) := '20202020206374782E66696C6C28293B0A202020207D3B0A0A202020205369676E61747572655061642E70726F746F747970652E5F7374726F6B655769647468203D2066756E6374696F6E202876656C6F6369747929207B0A2020202020202020726574';
wwv_flow_api.g_varchar2_table(111) := '75726E204D6174682E6D617828746869732E6D61785769647468202F202876656C6F63697479202B2031292C20746869732E6D696E5769647468293B0A202020207D3B0A0A0A2020202076617220506F696E74203D2066756E6374696F6E2028782C2079';
wwv_flow_api.g_varchar2_table(112) := '2C2074696D6529207B0A2020202020202020746869732E78203D20783B0A2020202020202020746869732E79203D20793B0A2020202020202020746869732E74696D65203D2074696D65207C7C206E6577204461746528292E67657454696D6528293B0A';
wwv_flow_api.g_varchar2_table(113) := '202020207D3B0A0A20202020506F696E742E70726F746F747970652E76656C6F6369747946726F6D203D2066756E6374696F6E2028737461727429207B0A202020202020202072657475726E2028746869732E74696D6520213D3D2073746172742E7469';
wwv_flow_api.g_varchar2_table(114) := '6D6529203F20746869732E64697374616E6365546F28737461727429202F2028746869732E74696D65202D2073746172742E74696D6529203A20313B0A202020207D3B0A0A20202020506F696E742E70726F746F747970652E64697374616E6365546F20';
wwv_flow_api.g_varchar2_table(115) := '3D2066756E6374696F6E2028737461727429207B0A202020202020202072657475726E204D6174682E73717274284D6174682E706F7728746869732E78202D2073746172742E782C203229202B204D6174682E706F7728746869732E79202D2073746172';
wwv_flow_api.g_varchar2_table(116) := '742E792C203229293B0A202020207D3B0A0A202020207661722042657A696572203D2066756E6374696F6E20287374617274506F696E742C20636F6E74726F6C312C20636F6E74726F6C322C20656E64506F696E7429207B0A2020202020202020746869';
wwv_flow_api.g_varchar2_table(117) := '732E7374617274506F696E74203D207374617274506F696E743B0A2020202020202020746869732E636F6E74726F6C31203D20636F6E74726F6C313B0A2020202020202020746869732E636F6E74726F6C32203D20636F6E74726F6C323B0A2020202020';
wwv_flow_api.g_varchar2_table(118) := '202020746869732E656E64506F696E74203D20656E64506F696E743B0A202020207D3B0A0A202020202F2F2052657475726E7320617070726F78696D61746564206C656E6774682E0A2020202042657A6965722E70726F746F747970652E6C656E677468';
wwv_flow_api.g_varchar2_table(119) := '203D2066756E6374696F6E202829207B0A2020202020202020766172207374657073203D2031302C0A2020202020202020202020206C656E677468203D20302C0A202020202020202020202020692C20742C2063782C2063792C2070782C2070792C2078';
wwv_flow_api.g_varchar2_table(120) := '646966662C2079646966663B0A0A2020202020202020666F72202869203D20303B2069203C3D2073746570733B20692B2B29207B0A20202020202020202020202074203D2069202F2073746570733B0A2020202020202020202020206378203D20746869';
wwv_flow_api.g_varchar2_table(121) := '732E5F706F696E7428742C20746869732E7374617274506F696E742E782C20746869732E636F6E74726F6C312E782C20746869732E636F6E74726F6C322E782C20746869732E656E64506F696E742E78293B0A2020202020202020202020206379203D20';
wwv_flow_api.g_varchar2_table(122) := '746869732E5F706F696E7428742C20746869732E7374617274506F696E742E792C20746869732E636F6E74726F6C312E792C20746869732E636F6E74726F6C322E792C20746869732E656E64506F696E742E79293B0A2020202020202020202020206966';
wwv_flow_api.g_varchar2_table(123) := '202869203E203029207B0A202020202020202020202020202020207864696666203D206378202D2070783B0A202020202020202020202020202020207964696666203D206379202D2070793B0A202020202020202020202020202020206C656E67746820';
wwv_flow_api.g_varchar2_table(124) := '2B3D204D6174682E73717274287864696666202A207864696666202B207964696666202A207964696666293B0A2020202020202020202020207D0A2020202020202020202020207078203D2063783B0A2020202020202020202020207079203D2063793B';
wwv_flow_api.g_varchar2_table(125) := '0A20202020202020207D0A202020202020202072657475726E206C656E6774683B0A202020207D3B0A0A2020202042657A6965722E70726F746F747970652E5F706F696E74203D2066756E6374696F6E2028742C2073746172742C2063312C2063322C20';
wwv_flow_api.g_varchar2_table(126) := '656E6429207B0A202020202020202072657475726E202020202020202020207374617274202A2028312E30202D207429202A2028312E30202D20742920202A2028312E30202D2074290A2020202020202020202020202020202B20332E30202A20206331';
wwv_flow_api.g_varchar2_table(127) := '202020202A2028312E30202D207429202A2028312E30202D20742920202A20740A2020202020202020202020202020202B20332E30202A20206332202020202A2028312E30202D207429202A2074202020202020202020202A20740A2020202020202020';
wwv_flow_api.g_varchar2_table(128) := '202020202020202B2020202020202020656E642020202A20742020202020202020202A2074202020202020202020202A20743B0A202020207D3B0A0A2020202072657475726E205369676E61747572655061643B0A7D2928646F63756D656E74293B0A0A';
wwv_flow_api.g_varchar2_table(129) := '72657475726E205369676E61747572655061643B0A0A7D29293B0A';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(61321561136421449)
,p_plugin_id=>wwv_flow_api.id(61258584527411566)
,p_file_name=>'js/signature_pad.js'
,p_mime_type=>'application/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '2166756E6374696F6E28612C62297B2266756E6374696F6E223D3D747970656F6620646566696E652626646566696E652E616D643F646566696E65285B5D2C66756E6374696F6E28297B72657475726E20612E5369676E61747572655061643D6228297D';
wwv_flow_api.g_varchar2_table(2) := '293A226F626A656374223D3D747970656F66206578706F7274733F6D6F64756C652E6578706F7274733D6228293A612E5369676E61747572655061643D6228297D28746869732C66756E6374696F6E28297B2F2A210A202A205369676E61747572652050';
wwv_flow_api.g_varchar2_table(3) := '61642076312E352E33207C2068747470733A2F2F6769746875622E636F6D2F737A696D656B2F7369676E61747572655F7061640A202A20286329203230313620537A796D6F6E204E6F77616B207C2052656C656173656420756E64657220746865204D49';
wwv_flow_api.g_varchar2_table(4) := '54206C6963656E73650A202A2F0A76617220613D66756E6374696F6E2861297B2275736520737472696374223B76617220623D66756E6374696F6E28612C62297B76617220633D746869732C643D627C7C7B7D3B746869732E76656C6F6369747946696C';
wwv_flow_api.g_varchar2_table(5) := '7465725765696768743D642E76656C6F6369747946696C7465725765696768747C7C2E372C746869732E6D696E57696474683D642E6D696E57696474687C7C2E352C746869732E6D617857696474683D642E6D617857696474687C7C322E352C74686973';
wwv_flow_api.g_varchar2_table(6) := '2E646F7453697A653D642E646F7453697A657C7C66756E6374696F6E28297B72657475726E28746869732E6D696E57696474682B746869732E6D61785769647468292F327D2C746869732E70656E436F6C6F723D642E70656E436F6C6F727C7C22626C61';
wwv_flow_api.g_varchar2_table(7) := '636B222C746869732E6261636B67726F756E64436F6C6F723D642E6261636B67726F756E64436F6C6F727C7C227267626128302C302C302C3029222C746869732E6F6E456E643D642E6F6E456E642C746869732E6F6E426567696E3D642E6F6E42656769';
wwv_flow_api.g_varchar2_table(8) := '6E2C746869732E5F63616E7661733D612C746869732E5F6374783D612E676574436F6E746578742822326422292C746869732E636C65617228292C746869732E5F68616E646C654D6F757365446F776E3D66756E6374696F6E2861297B313D3D3D612E77';
wwv_flow_api.g_varchar2_table(9) := '68696368262628632E5F6D6F757365427574746F6E446F776E3D21302C632E5F7374726F6B65426567696E286129297D2C746869732E5F68616E646C654D6F7573654D6F76653D66756E6374696F6E2861297B632E5F6D6F757365427574746F6E446F77';
wwv_flow_api.g_varchar2_table(10) := '6E2626632E5F7374726F6B655570646174652861297D2C746869732E5F68616E646C654D6F75736555703D66756E6374696F6E2861297B313D3D3D612E77686963682626632E5F6D6F757365427574746F6E446F776E262628632E5F6D6F757365427574';
wwv_flow_api.g_varchar2_table(11) := '746F6E446F776E3D21312C632E5F7374726F6B65456E64286129297D2C746869732E5F68616E646C65546F75636853746172743D66756E6374696F6E2861297B696628313D3D612E746172676574546F75636865732E6C656E677468297B76617220623D';
wwv_flow_api.g_varchar2_table(12) := '612E6368616E676564546F75636865735B305D3B632E5F7374726F6B65426567696E2862297D7D2C746869732E5F68616E646C65546F7563684D6F76653D66756E6374696F6E2861297B612E70726576656E7444656661756C7428293B76617220623D61';
wwv_flow_api.g_varchar2_table(13) := '2E746172676574546F75636865735B305D3B632E5F7374726F6B655570646174652862297D2C746869732E5F68616E646C65546F756368456E643D66756E6374696F6E2861297B76617220623D612E7461726765743D3D3D632E5F63616E7661733B6226';
wwv_flow_api.g_varchar2_table(14) := '2628612E70726576656E7444656661756C7428292C632E5F7374726F6B65456E64286129297D2C746869732E5F68616E646C654D6F7573654576656E747328292C746869732E5F68616E646C65546F7563684576656E747328297D3B622E70726F746F74';
wwv_flow_api.g_varchar2_table(15) := '7970652E636C6561723D66756E6374696F6E28297B76617220613D746869732E5F6374782C623D746869732E5F63616E7661733B612E66696C6C5374796C653D746869732E6261636B67726F756E64436F6C6F722C612E636C6561725265637428302C30';
wwv_flow_api.g_varchar2_table(16) := '2C622E77696474682C622E686569676874292C612E66696C6C5265637428302C302C622E77696474682C622E686569676874292C746869732E5F726573657428297D2C622E70726F746F747970652E746F4461746155524C3D66756E6374696F6E28297B';
wwv_flow_api.g_varchar2_table(17) := '76617220613D746869732E5F63616E7661733B72657475726E20612E746F4461746155524C2E6170706C7928612C617267756D656E7473297D2C622E70726F746F747970652E66726F6D4461746155524C3D66756E6374696F6E2861297B76617220623D';
wwv_flow_api.g_varchar2_table(18) := '746869732C633D6E657720496D6167652C643D77696E646F772E646576696365506978656C526174696F7C7C312C653D746869732E5F63616E7661732E77696474682F642C663D746869732E5F63616E7661732E6865696768742F643B746869732E5F72';
wwv_flow_api.g_varchar2_table(19) := '6573657428292C632E7372633D612C632E6F6E6C6F61643D66756E6374696F6E28297B622E5F6374782E64726177496D61676528632C302C302C652C66297D2C746869732E5F6973456D7074793D21317D2C622E70726F746F747970652E5F7374726F6B';
wwv_flow_api.g_varchar2_table(20) := '655570646174653D66756E6374696F6E2861297B76617220623D746869732E5F637265617465506F696E742861293B746869732E5F616464506F696E742862297D2C622E70726F746F747970652E5F7374726F6B65426567696E3D66756E6374696F6E28';
wwv_flow_api.g_varchar2_table(21) := '61297B746869732E5F726573657428292C746869732E5F7374726F6B655570646174652861292C2266756E6374696F6E223D3D747970656F6620746869732E6F6E426567696E2626746869732E6F6E426567696E2861297D2C622E70726F746F74797065';
wwv_flow_api.g_varchar2_table(22) := '2E5F7374726F6B65447261773D66756E6374696F6E2861297B76617220623D746869732E5F6374782C633D2266756E6374696F6E223D3D747970656F6620746869732E646F7453697A653F746869732E646F7453697A6528293A746869732E646F745369';
wwv_flow_api.g_varchar2_table(23) := '7A653B622E626567696E5061746828292C746869732E5F64726177506F696E7428612E782C612E792C63292C622E636C6F73655061746828292C622E66696C6C28297D2C622E70726F746F747970652E5F7374726F6B65456E643D66756E6374696F6E28';
wwv_flow_api.g_varchar2_table(24) := '61297B76617220623D746869732E706F696E74732E6C656E6774683E322C633D746869732E706F696E74735B305D3B21622626632626746869732E5F7374726F6B65447261772863292C2266756E6374696F6E223D3D747970656F6620746869732E6F6E';
wwv_flow_api.g_varchar2_table(25) := '456E642626746869732E6F6E456E642861297D2C622E70726F746F747970652E5F68616E646C654D6F7573654576656E74733D66756E6374696F6E28297B746869732E5F6D6F757365427574746F6E446F776E3D21312C746869732E5F63616E7661732E';
wwv_flow_api.g_varchar2_table(26) := '6164644576656E744C697374656E657228226D6F757365646F776E222C746869732E5F68616E646C654D6F757365446F776E292C746869732E5F63616E7661732E6164644576656E744C697374656E657228226D6F7573656D6F7665222C746869732E5F';
wwv_flow_api.g_varchar2_table(27) := '68616E646C654D6F7573654D6F7665292C612E6164644576656E744C697374656E657228226D6F7573657570222C746869732E5F68616E646C654D6F7573655570297D2C622E70726F746F747970652E5F68616E646C65546F7563684576656E74733D66';
wwv_flow_api.g_varchar2_table(28) := '756E6374696F6E28297B746869732E5F63616E7661732E7374796C652E6D73546F756368416374696F6E3D226E6F6E65222C746869732E5F63616E7661732E7374796C652E746F756368416374696F6E3D226E6F6E65222C746869732E5F63616E766173';
wwv_flow_api.g_varchar2_table(29) := '2E6164644576656E744C697374656E65722822746F7563687374617274222C746869732E5F68616E646C65546F7563685374617274292C746869732E5F63616E7661732E6164644576656E744C697374656E65722822746F7563686D6F7665222C746869';
wwv_flow_api.g_varchar2_table(30) := '732E5F68616E646C65546F7563684D6F7665292C746869732E5F63616E7661732E6164644576656E744C697374656E65722822746F756368656E64222C746869732E5F68616E646C65546F756368456E64297D2C622E70726F746F747970652E6F6E3D66';
wwv_flow_api.g_varchar2_table(31) := '756E6374696F6E28297B746869732E5F68616E646C654D6F7573654576656E747328292C746869732E5F68616E646C65546F7563684576656E747328297D2C622E70726F746F747970652E6F66663D66756E6374696F6E28297B746869732E5F63616E76';
wwv_flow_api.g_varchar2_table(32) := '61732E72656D6F76654576656E744C697374656E657228226D6F757365646F776E222C746869732E5F68616E646C654D6F757365446F776E292C746869732E5F63616E7661732E72656D6F76654576656E744C697374656E657228226D6F7573656D6F76';
wwv_flow_api.g_varchar2_table(33) := '65222C746869732E5F68616E646C654D6F7573654D6F7665292C612E72656D6F76654576656E744C697374656E657228226D6F7573657570222C746869732E5F68616E646C654D6F7573655570292C746869732E5F63616E7661732E72656D6F76654576';
wwv_flow_api.g_varchar2_table(34) := '656E744C697374656E65722822746F7563687374617274222C746869732E5F68616E646C65546F7563685374617274292C746869732E5F63616E7661732E72656D6F76654576656E744C697374656E65722822746F7563686D6F7665222C746869732E5F';
wwv_flow_api.g_varchar2_table(35) := '68616E646C65546F7563684D6F7665292C746869732E5F63616E7661732E72656D6F76654576656E744C697374656E65722822746F756368656E64222C746869732E5F68616E646C65546F756368456E64297D2C622E70726F746F747970652E6973456D';
wwv_flow_api.g_varchar2_table(36) := '7074793D66756E6374696F6E28297B72657475726E20746869732E5F6973456D7074797D2C622E70726F746F747970652E5F72657365743D66756E6374696F6E28297B746869732E706F696E74733D5B5D2C746869732E5F6C61737456656C6F63697479';
wwv_flow_api.g_varchar2_table(37) := '3D302C746869732E5F6C61737457696474683D28746869732E6D696E57696474682B746869732E6D61785769647468292F322C746869732E5F6973456D7074793D21302C746869732E5F6374782E66696C6C5374796C653D746869732E70656E436F6C6F';
wwv_flow_api.g_varchar2_table(38) := '727D2C622E70726F746F747970652E5F637265617465506F696E743D66756E6374696F6E2861297B76617220623D746869732E5F63616E7661732E676574426F756E64696E67436C69656E745265637428293B72657475726E206E6577206328612E636C';
wwv_flow_api.g_varchar2_table(39) := '69656E74582D622E6C6566742C612E636C69656E74592D622E746F70297D2C622E70726F746F747970652E5F616464506F696E743D66756E6374696F6E2861297B76617220622C632C652C662C673D746869732E706F696E74733B672E70757368286129';
wwv_flow_api.g_varchar2_table(40) := '2C672E6C656E6774683E32262628333D3D3D672E6C656E6774682626672E756E736869667428675B305D292C663D746869732E5F63616C63756C6174654375727665436F6E74726F6C506F696E747328675B305D2C675B315D2C675B325D292C623D662E';
wwv_flow_api.g_varchar2_table(41) := '63322C663D746869732E5F63616C63756C6174654375727665436F6E74726F6C506F696E747328675B315D2C675B325D2C675B335D292C633D662E63312C653D6E6577206428675B315D2C622C632C675B325D292C746869732E5F616464437572766528';
wwv_flow_api.g_varchar2_table(42) := '65292C672E73686966742829297D2C622E70726F746F747970652E5F63616C63756C6174654375727665436F6E74726F6C506F696E74733D66756E6374696F6E28612C622C64297B76617220653D612E782D622E782C663D612E792D622E792C673D622E';
wwv_flow_api.g_varchar2_table(43) := '782D642E782C683D622E792D642E792C693D7B783A28612E782B622E78292F322C793A28612E792B622E79292F327D2C6A3D7B783A28622E782B642E78292F322C793A28622E792B642E79292F327D2C6B3D4D6174682E7371727428652A652B662A6629';
wwv_flow_api.g_varchar2_table(44) := '2C6C3D4D6174682E7371727428672A672B682A68292C6D3D692E782D6A2E782C6E3D692E792D6A2E792C6F3D6C2F286B2B6C292C703D7B783A6A2E782B6D2A6F2C793A6A2E792B6E2A6F7D2C713D622E782D702E782C723D622E792D702E793B72657475';
wwv_flow_api.g_varchar2_table(45) := '726E7B63313A6E6577206328692E782B712C692E792B72292C63323A6E65772063286A2E782B712C6A2E792B72297D7D2C622E70726F746F747970652E5F61646443757276653D66756E6374696F6E2861297B76617220622C632C643D612E7374617274';
wwv_flow_api.g_varchar2_table(46) := '506F696E742C653D612E656E64506F696E743B623D652E76656C6F6369747946726F6D2864292C623D746869732E76656C6F6369747946696C7465725765696768742A622B28312D746869732E76656C6F6369747946696C746572576569676874292A74';
wwv_flow_api.g_varchar2_table(47) := '6869732E5F6C61737456656C6F636974792C633D746869732E5F7374726F6B6557696474682862292C746869732E5F64726177437572766528612C746869732E5F6C61737457696474682C63292C746869732E5F6C61737456656C6F636974793D622C74';
wwv_flow_api.g_varchar2_table(48) := '6869732E5F6C61737457696474683D637D2C622E70726F746F747970652E5F64726177506F696E743D66756E6374696F6E28612C622C63297B76617220643D746869732E5F6374783B642E6D6F7665546F28612C62292C642E61726328612C622C632C30';
wwv_flow_api.g_varchar2_table(49) := '2C322A4D6174682E50492C2131292C746869732E5F6973456D7074793D21317D2C622E70726F746F747970652E5F6472617743757276653D66756E6374696F6E28612C622C63297B76617220642C652C662C672C682C692C6A2C6B2C6C2C6D2C6E2C6F3D';
wwv_flow_api.g_varchar2_table(50) := '746869732E5F6374782C703D632D623B666F7228643D4D6174682E666C6F6F7228612E6C656E6774682829292C6F2E626567696E5061746828292C663D303B643E663B662B2B29673D662F642C683D672A672C693D682A672C6A3D312D672C6B3D6A2A6A';
wwv_flow_api.g_varchar2_table(51) := '2C6C3D6B2A6A2C6D3D6C2A612E7374617274506F696E742E782C6D2B3D332A6B2A672A612E636F6E74726F6C312E782C6D2B3D332A6A2A682A612E636F6E74726F6C322E782C6D2B3D692A612E656E64506F696E742E782C6E3D6C2A612E737461727450';
wwv_flow_api.g_varchar2_table(52) := '6F696E742E792C6E2B3D332A6B2A672A612E636F6E74726F6C312E792C6E2B3D332A6A2A682A612E636F6E74726F6C322E792C6E2B3D692A612E656E64506F696E742E792C653D622B692A702C746869732E5F64726177506F696E74286D2C6E2C65293B';
wwv_flow_api.g_varchar2_table(53) := '6F2E636C6F73655061746828292C6F2E66696C6C28297D2C622E70726F746F747970652E5F7374726F6B6557696474683D66756E6374696F6E2861297B72657475726E204D6174682E6D617828746869732E6D617857696474682F28612B31292C746869';
wwv_flow_api.g_varchar2_table(54) := '732E6D696E5769647468297D3B76617220633D66756E6374696F6E28612C622C63297B746869732E783D612C746869732E793D622C746869732E74696D653D637C7C286E65772044617465292E67657454696D6528297D3B632E70726F746F747970652E';
wwv_flow_api.g_varchar2_table(55) := '76656C6F6369747946726F6D3D66756E6374696F6E2861297B72657475726E20746869732E74696D65213D3D612E74696D653F746869732E64697374616E6365546F2861292F28746869732E74696D652D612E74696D65293A317D2C632E70726F746F74';
wwv_flow_api.g_varchar2_table(56) := '7970652E64697374616E6365546F3D66756E6374696F6E2861297B72657475726E204D6174682E73717274284D6174682E706F7728746869732E782D612E782C32292B4D6174682E706F7728746869732E792D612E792C3229297D3B76617220643D6675';
wwv_flow_api.g_varchar2_table(57) := '6E6374696F6E28612C622C632C64297B746869732E7374617274506F696E743D612C746869732E636F6E74726F6C313D622C746869732E636F6E74726F6C323D632C746869732E656E64506F696E743D647D3B72657475726E20642E70726F746F747970';
wwv_flow_api.g_varchar2_table(58) := '652E6C656E6774683D66756E6374696F6E28297B76617220612C622C632C642C652C662C672C682C693D31302C6A3D303B666F7228613D303B693E3D613B612B2B29623D612F692C633D746869732E5F706F696E7428622C746869732E7374617274506F';
wwv_flow_api.g_varchar2_table(59) := '696E742E782C746869732E636F6E74726F6C312E782C746869732E636F6E74726F6C322E782C746869732E656E64506F696E742E78292C643D746869732E5F706F696E7428622C746869732E7374617274506F696E742E792C746869732E636F6E74726F';
wwv_flow_api.g_varchar2_table(60) := '6C312E792C746869732E636F6E74726F6C322E792C746869732E656E64506F696E742E79292C613E30262628673D632D652C683D642D662C6A2B3D4D6174682E7371727428672A672B682A6829292C653D632C663D643B72657475726E206A7D2C642E70';
wwv_flow_api.g_varchar2_table(61) := '726F746F747970652E5F706F696E743D66756E6374696F6E28612C622C632C642C65297B72657475726E20622A28312D61292A28312D61292A28312D61292B332A632A28312D61292A28312D61292A612B332A642A28312D61292A612A612B652A612A61';
wwv_flow_api.g_varchar2_table(62) := '2A617D2C627D28646F63756D656E74293B72657475726E20617D293B';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(61321962308422120)
,p_plugin_id=>wwv_flow_api.id(61258584527411566)
,p_file_name=>'js/signature_pad.min.js'
,p_mime_type=>'application/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '2F2F2041504558205369676E61747572652066756E6374696F6E730A2F2F20417574686F723A2044616E69656C20486F63686C6569746E65720A2F2F2056657273696F6E3A20312E310A0A2F2F20676C6F62616C206E616D6573706163650A7661722061';
wwv_flow_api.g_varchar2_table(2) := '7065785369676E6174757265203D207B0A202020202F2F20706172736520737472696E6720746F20626F6F6C65616E0A202020207061727365426F6F6C65616E3A2066756E6374696F6E2870537472696E6729207B0A2020202020202020766172207042';
wwv_flow_api.g_varchar2_table(3) := '6F6F6C65616E3B0A20202020202020206966202870537472696E672E746F4C6F776572436173652829203D3D2027747275652729207B0A20202020202020202020202070426F6F6C65616E203D20747275653B0A20202020202020207D0A202020202020';
wwv_flow_api.g_varchar2_table(4) := '20206966202870537472696E672E746F4C6F776572436173652829203D3D202766616C73652729207B0A20202020202020202020202070426F6F6C65616E203D2066616C73653B0A20202020202020207D0A202020202020202069662028212870537472';
wwv_flow_api.g_varchar2_table(5) := '696E672E746F4C6F776572436173652829203D3D202774727565272920262620212870537472696E672E746F4C6F776572436173652829203D3D202766616C7365272929207B0A20202020202020202020202070426F6F6C65616E203D20756E64656669';
wwv_flow_api.g_varchar2_table(6) := '6E65643B0A20202020202020207D0A202020202020202072657475726E2070426F6F6C65616E3B0A202020207D2C0A202020202F2F206275696C64732061206A732061727261792066726F6D206C6F6E6720737472696E670A20202020636C6F62324172';
wwv_flow_api.g_varchar2_table(7) := '7261793A2066756E6374696F6E28636C6F622C2073697A652C20617272617929207B0A20202020202020206C6F6F70436F756E74203D204D6174682E666C6F6F7228636C6F622E6C656E677468202F2073697A6529202B20313B0A202020202020202066';
wwv_flow_api.g_varchar2_table(8) := '6F7220287661722069203D20303B2069203C206C6F6F70436F756E743B20692B2B29207B0A20202020202020202020202061727261792E7075736828636C6F622E736C6963652873697A65202A20692C2073697A65202A202869202B20312929293B0A20';
wwv_flow_api.g_varchar2_table(9) := '202020202020207D0A202020202020202072657475726E2061727261793B0A202020207D2C0A202020202F2F20636F6E7665727473204461746155524920746F2062617365363420737472696E670A2020202064617461555249326261736536343A2066';
wwv_flow_api.g_varchar2_table(10) := '756E6374696F6E286461746155524929207B0A202020202020202076617220626173653634203D20646174615552492E73756273747228646174615552492E696E6465784F6628272C2729202B2031293B0A202020202020202072657475726E20626173';
wwv_flow_api.g_varchar2_table(11) := '6536343B0A202020207D2C0A202020202F2F207361766520746F2044422066756E6374696F6E0A20202020736176653244623A2066756E6374696F6E28704F7074696F6E732C2070526567696F6E49642C2070496D672C2063616C6C6261636B29207B0A';
wwv_flow_api.g_varchar2_table(12) := '20202020202020202F2F20696D67204461746155524920746F206261736536340A202020202020202076617220626173653634203D20617065785369676E61747572652E64617461555249326261736536342870496D67293B0A20202020202020202F2F';
wwv_flow_api.g_varchar2_table(13) := '2073706C69742062617365363420636C6F6220737472696E6720746F20663031206172726179206C656E6774682033306B0A2020202020202020766172206630314172726179203D205B5D3B0A20202020202020206630314172726179203D2061706578';
wwv_flow_api.g_varchar2_table(14) := '5369676E61747572652E636C6F62324172726179286261736536342C2033303030302C206630314172726179293B0A20202020202020202F2F204170657820416A61782043616C6C0A2020202020202020617065782E7365727665722E706C7567696E28';
wwv_flow_api.g_varchar2_table(15) := '704F7074696F6E732E616A61784964656E7469666965722C207B0A2020202020202020202020206630313A2066303141727261792C0A2020202020202020202020202F2F202331333A20416C6C6F777320666F72206974656D7320746F20626520737562';
wwv_flow_api.g_varchar2_table(16) := '6D69747465640A202020202020202020202020706167654974656D733A20704F7074696F6E732E616A61784974656D73546F5375626D69742E73706C697428272C27290A20202020202020207D2C207B0A20202020202020202020202064617461547970';
wwv_flow_api.g_varchar2_table(17) := '653A202768746D6C272C0A2020202020202020202020202F2F205355434553532066756E6374696F6E0A202020202020202020202020737563636573733A2066756E6374696F6E2829207B0A202020202020202020202020202020202F2F206164642061';
wwv_flow_api.g_varchar2_table(18) := '706578206576656E740A202020202020202020202020202020202428272327202B2070526567696F6E4964292E747269676765722827617065787369676E61747572652D73617665642D646227293B0A202020202020202020202020202020202F2F2063';
wwv_flow_api.g_varchar2_table(19) := '616C6C6261636B0A2020202020202020202020202020202063616C6C6261636B28293B0A2020202020202020202020207D2C0A2020202020202020202020202F2F204552524F522066756E6374696F6E0A2020202020202020202020206572726F723A20';
wwv_flow_api.g_varchar2_table(20) := '66756E6374696F6E287868722C20704D65737361676529207B0A202020202020202020202020202020202F2F206164642061706578206576656E740A202020202020202020202020202020202428272327202B2070526567696F6E4964292E7472696767';
wwv_flow_api.g_varchar2_table(21) := '65722827617065787369676E61747572652D6572726F722D646227293B0A20202020202020202020202020202020636F6E736F6C652E6C6F672827736176653244623A20617065782E7365727665722E706C7567696E204552524F523A272C20704D6573';
wwv_flow_api.g_varchar2_table(22) := '73616765293B0A202020202020202020202020202020202F2F2063616C6C6261636B0A2020202020202020202020202020202063616C6C6261636B28293B0A2020202020202020202020207D0A20202020202020207D293B0A202020207D2C0A20202020';
wwv_flow_api.g_varchar2_table(23) := '2F2F2066756E6374696F6E207468617420676574732063616C6C65642066726F6D20706C7567696E0A20202020617065785369676E6174757265466E633A2066756E6374696F6E2870526567696F6E49642C20704F7074696F6E732C20704C6F6767696E';
wwv_flow_api.g_varchar2_table(24) := '6729207B0A202020202020202076617220764F7074696F6E73203D20704F7074696F6E733B0A2020202020202020766172207643616E76617324203D20646F63756D656E742E676574456C656D656E744279496428764F7074696F6E732E63616E766173';
wwv_flow_api.g_varchar2_table(25) := '4964293B0A202020202020202076617220764C6F6767696E67203D20617065785369676E61747572652E7061727365426F6F6C65616E28704C6F6767696E67293B0A202020202020202076617220764D696E5769647468203D207061727365496E742876';
wwv_flow_api.g_varchar2_table(26) := '4F7074696F6E732E6C696E654D696E5769647468293B0A202020202020202076617220764D61785769647468203D207061727365496E7428764F7074696F6E732E6C696E654D61785769647468293B0A20202020202020207661722076436C6561724274';
wwv_flow_api.g_varchar2_table(27) := '6E53656C6563746F72203D20764F7074696F6E732E636C656172427574746F6E3B0A202020202020202076617220765361766542746E53656C6563746F72203D20764F7074696F6E732E73617665427574746F6E3B0A2020202020202020766172207645';
wwv_flow_api.g_varchar2_table(28) := '6D707479416C657274203D20764F7074696F6E732E656D707479416C6572743B0A2020202020202020766172207653686F775370696E6E6572203D20617065785369676E61747572652E7061727365426F6F6C65616E28764F7074696F6E732E73686F77';
wwv_flow_api.g_varchar2_table(29) := '5370696E6E6572293B0A2020202020202020766172207643616E7661735769647468203D207643616E766173242E77696474683B0A2020202020202020766172207643616E766173486569676874203D207643616E766173242E6865696768743B0A2020';
wwv_flow_api.g_varchar2_table(30) := '2020202020207661722076436C69656E745769647468203D207061727365496E7428646F63756D656E742E646F63756D656E74456C656D656E742E636C69656E745769647468293B0A202020202020202076617220764369656E74486569676874203D20';
wwv_flow_api.g_varchar2_table(31) := '7061727365496E7428646F63756D656E742E646F63756D656E74456C656D656E742E636C69656E74486569676874293B0A20202020202020202F2F204C6F6767696E670A202020202020202069662028764C6F6767696E6729207B0A2020202020202020';
wwv_flow_api.g_varchar2_table(32) := '20202020636F6E736F6C652E6C6F672827617065785369676E6174757265466E633A20764F7074696F6E732E616A61784964656E7469666965723A272C20764F7074696F6E732E616A61784964656E746966696572293B0A202020202020202020202020';
wwv_flow_api.g_varchar2_table(33) := '636F6E736F6C652E6C6F672827617065785369676E6174757265466E633A20764F7074696F6E732E616A61784974656D73546F5375626D69743A272C20764F7074696F6E732E616A61784974656D73546F5375626D6974293B0A20202020202020202020';
wwv_flow_api.g_varchar2_table(34) := '2020636F6E736F6C652E6C6F672827617065785369676E6174757265466E633A20764F7074696F6E732E63616E76617349643A272C20764F7074696F6E732E63616E7661734964293B0A202020202020202020202020636F6E736F6C652E6C6F67282761';
wwv_flow_api.g_varchar2_table(35) := '7065785369676E6174757265466E633A20764F7074696F6E732E6C696E654D696E57696474683A272C20764F7074696F6E732E6C696E654D696E5769647468293B0A202020202020202020202020636F6E736F6C652E6C6F672827617065785369676E61';
wwv_flow_api.g_varchar2_table(36) := '74757265466E633A20764F7074696F6E732E6C696E654D617857696474683A272C20764F7074696F6E732E6C696E654D61785769647468293B0A202020202020202020202020636F6E736F6C652E6C6F672827617065785369676E6174757265466E633A';
wwv_flow_api.g_varchar2_table(37) := '20764F7074696F6E732E6261636B67726F756E64436F6C6F723A272C20764F7074696F6E732E6261636B67726F756E64436F6C6F72293B0A202020202020202020202020636F6E736F6C652E6C6F672827617065785369676E6174757265466E633A2076';
wwv_flow_api.g_varchar2_table(38) := '4F7074696F6E732E70656E436F6C6F723A272C20764F7074696F6E732E70656E436F6C6F72293B0A202020202020202020202020636F6E736F6C652E6C6F672827617065785369676E6174757265466E633A20764F7074696F6E732E7361766542757474';
wwv_flow_api.g_varchar2_table(39) := '6F6E3A272C20764F7074696F6E732E73617665427574746F6E293B0A202020202020202020202020636F6E736F6C652E6C6F672827617065785369676E6174757265466E633A20764F7074696F6E732E636C656172427574746F6E3A272C20764F707469';
wwv_flow_api.g_varchar2_table(40) := '6F6E732E636C656172427574746F6E293B0A202020202020202020202020636F6E736F6C652E6C6F672827617065785369676E6174757265466E633A20764F7074696F6E732E656D707479416C6572743A272C20764F7074696F6E732E656D707479416C';
wwv_flow_api.g_varchar2_table(41) := '657274293B0A202020202020202020202020636F6E736F6C652E6C6F672827617065785369676E6174757265466E633A20764F7074696F6E732E73686F775370696E6E65723A272C20764F7074696F6E732E73686F775370696E6E6572293B0A20202020';
wwv_flow_api.g_varchar2_table(42) := '2020202020202020636F6E736F6C652E6C6F672827617065785369676E6174757265466E633A2070526567696F6E49643A272C2070526567696F6E4964293B0A202020202020202020202020636F6E736F6C652E6C6F672827617065785369676E617475';
wwv_flow_api.g_varchar2_table(43) := '7265466E633A207643616E76617357696474683A272C207643616E7661735769647468293B0A202020202020202020202020636F6E736F6C652E6C6F672827617065785369676E6174757265466E633A207643616E7661734865696768743A272C207643';
wwv_flow_api.g_varchar2_table(44) := '616E766173486569676874293B0A202020202020202020202020636F6E736F6C652E6C6F672827617065785369676E6174757265466E633A2076436C69656E7457696474683A272C2076436C69656E745769647468293B0A202020202020202020202020';
wwv_flow_api.g_varchar2_table(45) := '636F6E736F6C652E6C6F672827617065785369676E6174757265466E633A20764369656E744865696768743A272C207643616E766173486569676874293B0A20202020202020207D0A20202020202020202F2F20726573697A652063616E766173206966';
wwv_flow_api.g_varchar2_table(46) := '2073637265656E20736D616C6C6572207468616E2063616E7661730A2020202020202020696620287643616E7661735769647468203E2076436C69656E74576964746829207B0A2020202020202020202020207643616E766173242E7769647468203D20';
wwv_flow_api.g_varchar2_table(47) := '76436C69656E745769647468202D2036303B0A20202020202020207D0A2020202020202020696620287643616E766173486569676874203E20764369656E7448656967687429207B0A2020202020202020202020207643616E766173242E686569676874';
wwv_flow_api.g_varchar2_table(48) := '203D20764369656E74486569676874202D2036303B0A20202020202020207D0A20202020202020202F2F205349474E41545552455041440A20202020202020202F2F20637265617465207369676E61747572655061640A20202020202020207661722073';
wwv_flow_api.g_varchar2_table(49) := '69676E6174757265506164203D206E6577205369676E6174757265506164287643616E766173242C207B0A2020202020202020202020206D696E57696474683A20764D696E57696474682C0A2020202020202020202020206D617857696474683A20764D';
wwv_flow_api.g_varchar2_table(50) := '617857696474682C0A2020202020202020202020206261636B67726F756E64436F6C6F723A20764F7074696F6E732E6261636B67726F756E64436F6C6F722C0A20202020202020202020202070656E436F6C6F723A20764F7074696F6E732E70656E436F';
wwv_flow_api.g_varchar2_table(51) := '6C6F720A20202020202020207D293B0A20202020202020202F2F20636C656172207369676E61747572655061640A2020202020202020242876436C65617242746E53656C6563746F72292E636C69636B2866756E6374696F6E2829207B0A202020202020';
wwv_flow_api.g_varchar2_table(52) := '2020202020207369676E61747572655061642E636C65617228293B0A2020202020202020202020202F2F206164642061706578206576656E740A2020202020202020202020202428272327202B2070526567696F6E4964292E7472696767657228276170';
wwv_flow_api.g_varchar2_table(53) := '65787369676E61747572652D636C656172656427293B0A20202020202020207D293B0A20202020202020202F2F2073617665207369676E617475726550616420746F2044420A20202020202020202428765361766542746E53656C6563746F72292E636C';
wwv_flow_api.g_varchar2_table(54) := '69636B2866756E6374696F6E2829207B0A20202020202020202020202076617220764973456D707479203D207369676E61747572655061642E6973456D70747928293B0A2020202020202020202020202F2F206F6E6C79207768656E207369676E617475';
wwv_flow_api.g_varchar2_table(55) := '7265206973206E6F7420656D7074790A20202020202020202020202069662028764973456D707479203D3D3D2066616C736529207B0A202020202020202020202020202020202F2F2073686F772077616974207370696E6E65720A202020202020202020';
wwv_flow_api.g_varchar2_table(56) := '20202020202020696620287653686F775370696E6E657229207B0A2020202020202020202020202020202020202020766172206C5370696E6E657224203D20617065782E7574696C2E73686F775370696E6E6572282428272327202B2070526567696F6E';
wwv_flow_api.g_varchar2_table(57) := '496429293B0A202020202020202020202020202020207D0A202020202020202020202020202020202F2F207361766520696D6167650A202020202020202020202020202020207661722076496D67203D207369676E61747572655061642E746F44617461';
wwv_flow_api.g_varchar2_table(58) := '55524C28293B0A20202020202020202020202020202020617065785369676E61747572652E7361766532446228764F7074696F6E732C2070526567696F6E49642C2076496D672C2066756E6374696F6E2829207B0A202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(59) := '20202020202F2F20636C6561720A20202020202020202020202020202020202020207369676E61747572655061642E636C65617228293B0A20202020202020202020202020202020202020202F2F2072656D6F76652077616974207370696E6E65720A20';
wwv_flow_api.g_varchar2_table(60) := '20202020202020202020202020202020202020696620287653686F775370696E6E657229207B0A2020202020202020202020202020202020202020202020206C5370696E6E6572242E72656D6F766528293B0A2020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(61) := '2020207D0A202020202020202020202020202020207D293B0A202020202020202020202020202020202F2F20697320656D7074790A2020202020202020202020207D20656C7365207B0A20202020202020202020202020202020616C6572742876456D70';
wwv_flow_api.g_varchar2_table(62) := '7479416C657274293B0A2020202020202020202020207D0A20202020202020207D293B0A202020207D0A7D3B0A';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(61332993875838730)
,p_plugin_id=>wwv_flow_api.id(61258584527411566)
,p_file_name=>'js/apexsignature.js'
,p_mime_type=>'application/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '76617220617065785369676E61747572653D7B7061727365426F6F6C65616E3A66756E6374696F6E2865297B766172206E3B72657475726E2274727565223D3D652E746F4C6F7765724361736528292626286E3D2130292C2266616C7365223D3D652E74';
wwv_flow_api.g_varchar2_table(2) := '6F4C6F7765724361736528292626286E3D2131292C227472756522213D652E746F4C6F77657243617365282926262266616C736522213D652E746F4C6F7765724361736528292626286E3D766F69642030292C6E7D2C636C6F623241727261793A66756E';
wwv_flow_api.g_varchar2_table(3) := '6374696F6E28652C6E2C6F297B6C6F6F70436F756E743D4D6174682E666C6F6F7228652E6C656E6774682F6E292B313B666F722876617220613D303B613C6C6F6F70436F756E743B612B2B296F2E7075736828652E736C696365286E2A612C6E2A28612B';
wwv_flow_api.g_varchar2_table(4) := '312929293B72657475726E206F7D2C64617461555249326261736536343A66756E6374696F6E2865297B72657475726E20652E73756273747228652E696E6465784F6628222C22292B31297D2C736176653244623A66756E6374696F6E28652C6E2C6F2C';
wwv_flow_api.g_varchar2_table(5) := '61297B76617220743D617065785369676E61747572652E6461746155524932626173653634286F292C693D5B5D3B693D617065785369676E61747572652E636C6F6232417272617928742C3365342C69292C617065782E7365727665722E706C7567696E';
wwv_flow_api.g_varchar2_table(6) := '28652E616A61784964656E7469666965722C7B6630313A692C706167654974656D733A652E616A61784974656D73546F5375626D69742E73706C697428222C22297D2C7B64617461547970653A2268746D6C222C737563636573733A66756E6374696F6E';
wwv_flow_api.g_varchar2_table(7) := '28297B24282223222B6E292E747269676765722822617065787369676E61747572652D73617665642D646222292C6128297D2C6572726F723A66756E6374696F6E28652C6F297B24282223222B6E292E747269676765722822617065787369676E617475';
wwv_flow_api.g_varchar2_table(8) := '72652D6572726F722D646222292C636F6E736F6C652E6C6F672822736176653244623A20617065782E7365727665722E706C7567696E204552524F523A222C6F292C6128297D7D297D2C617065785369676E6174757265466E633A66756E6374696F6E28';
wwv_flow_api.g_varchar2_table(9) := '652C6E2C6F297B76617220613D6E2C743D646F63756D656E742E676574456C656D656E744279496428612E63616E7661734964292C693D617065785369676E61747572652E7061727365426F6F6C65616E286F292C723D7061727365496E7428612E6C69';
wwv_flow_api.g_varchar2_table(10) := '6E654D696E5769647468292C6C3D7061727365496E7428612E6C696E654D61785769647468292C733D612E636C656172427574746F6E2C633D612E73617665427574746F6E2C703D612E656D707479416C6572742C753D617065785369676E6174757265';
wwv_flow_api.g_varchar2_table(11) := '2E7061727365426F6F6C65616E28612E73686F775370696E6E6572292C673D742E77696474682C643D742E6865696768742C783D7061727365496E7428646F63756D656E742E646F63756D656E74456C656D656E742E636C69656E745769647468292C76';
wwv_flow_api.g_varchar2_table(12) := '3D7061727365496E7428646F63756D656E742E646F63756D656E74456C656D656E742E636C69656E74486569676874293B69262628636F6E736F6C652E6C6F672822617065785369676E6174757265466E633A20764F7074696F6E732E616A6178496465';
wwv_flow_api.g_varchar2_table(13) := '6E7469666965723A222C612E616A61784964656E746966696572292C636F6E736F6C652E6C6F672822617065785369676E6174757265466E633A20764F7074696F6E732E616A61784974656D73546F5375626D69743A222C612E616A61784974656D7354';
wwv_flow_api.g_varchar2_table(14) := '6F5375626D6974292C636F6E736F6C652E6C6F672822617065785369676E6174757265466E633A20764F7074696F6E732E63616E76617349643A222C612E63616E7661734964292C636F6E736F6C652E6C6F672822617065785369676E6174757265466E';
wwv_flow_api.g_varchar2_table(15) := '633A20764F7074696F6E732E6C696E654D696E57696474683A222C612E6C696E654D696E5769647468292C636F6E736F6C652E6C6F672822617065785369676E6174757265466E633A20764F7074696F6E732E6C696E654D617857696474683A222C612E';
wwv_flow_api.g_varchar2_table(16) := '6C696E654D61785769647468292C636F6E736F6C652E6C6F672822617065785369676E6174757265466E633A20764F7074696F6E732E6261636B67726F756E64436F6C6F723A222C612E6261636B67726F756E64436F6C6F72292C636F6E736F6C652E6C';
wwv_flow_api.g_varchar2_table(17) := '6F672822617065785369676E6174757265466E633A20764F7074696F6E732E70656E436F6C6F723A222C612E70656E436F6C6F72292C636F6E736F6C652E6C6F672822617065785369676E6174757265466E633A20764F7074696F6E732E736176654275';
wwv_flow_api.g_varchar2_table(18) := '74746F6E3A222C612E73617665427574746F6E292C636F6E736F6C652E6C6F672822617065785369676E6174757265466E633A20764F7074696F6E732E636C656172427574746F6E3A222C612E636C656172427574746F6E292C636F6E736F6C652E6C6F';
wwv_flow_api.g_varchar2_table(19) := '672822617065785369676E6174757265466E633A20764F7074696F6E732E656D707479416C6572743A222C612E656D707479416C657274292C636F6E736F6C652E6C6F672822617065785369676E6174757265466E633A20764F7074696F6E732E73686F';
wwv_flow_api.g_varchar2_table(20) := '775370696E6E65723A222C612E73686F775370696E6E6572292C636F6E736F6C652E6C6F672822617065785369676E6174757265466E633A2070526567696F6E49643A222C65292C636F6E736F6C652E6C6F672822617065785369676E6174757265466E';
wwv_flow_api.g_varchar2_table(21) := '633A207643616E76617357696474683A222C67292C636F6E736F6C652E6C6F672822617065785369676E6174757265466E633A207643616E7661734865696768743A222C64292C636F6E736F6C652E6C6F672822617065785369676E6174757265466E63';
wwv_flow_api.g_varchar2_table(22) := '3A2076436C69656E7457696474683A222C78292C636F6E736F6C652E6C6F672822617065785369676E6174757265466E633A20764369656E744865696768743A222C6429292C673E78262628742E77696474683D782D3630292C643E76262628742E6865';
wwv_flow_api.g_varchar2_table(23) := '696768743D762D3630293B76617220533D6E6577205369676E617475726550616428742C7B6D696E57696474683A722C6D617857696474683A6C2C6261636B67726F756E64436F6C6F723A612E6261636B67726F756E64436F6C6F722C70656E436F6C6F';
wwv_flow_api.g_varchar2_table(24) := '723A612E70656E436F6C6F727D293B242873292E636C69636B282866756E6374696F6E28297B532E636C65617228292C24282223222B65292E747269676765722822617065787369676E61747572652D636C656172656422297D29292C242863292E636C';
wwv_flow_api.g_varchar2_table(25) := '69636B282866756E6374696F6E28297B69662821313D3D3D532E6973456D7074792829297B6966287529766172206E3D617065782E7574696C2E73686F775370696E6E65722824282223222B6529293B766172206F3D532E746F4461746155524C28293B';
wwv_flow_api.g_varchar2_table(26) := '617065785369676E61747572652E7361766532446228612C652C6F2C2866756E6374696F6E28297B532E636C65617228292C7526266E2E72656D6F766528297D29297D656C736520616C6572742870297D29297D7D3B0A2F2F2320736F757263654D6170';
wwv_flow_api.g_varchar2_table(27) := '70696E6755524C3D617065787369676E61747572652E6A732E6D6170';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(61333441824839312)
,p_plugin_id=>wwv_flow_api.id(61258584527411566)
,p_file_name=>'js/apexsignature.min.js'
,p_mime_type=>'application/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
prompt --application/end_environment
begin
wwv_flow_api.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false));
commit;
end;
/
set verify on feedback on define on
prompt  ...done
