--高速决斗技能-凡人融合
Duel.LoadScript("speed_duel_common.lua")
function c100730073.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730073.skill,c100730073.con,aux.Stringid(100730073,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730073.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	local mg1=Duel.GetFusionMaterial(tp)
	local res=Duel.IsExistingMatchingCard(c100730073.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,mg1,nil,tp)
	if not res then
		local ce=Duel.GetChainMaterial(tp)
		if ce~=nil then
			local fgroup=ce:GetTarget()
			local mg2=fgroup(ce,e,tp)
			local mf=ce:GetValue()
			res=Duel.IsExistingMatchingCard(c100730073.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,mg2,mf,tp)
		end
		return res
	end
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsPlayerCanSpecialSummon(tp)
		and Duel.GetMZoneCount(tp)>1
end
function c100730073.skill(e,tp,c)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730073)
	local chkf=tp
	local mg1=Duel.GetFusionMaterial(tp):Filter(c100730073.filter1,nil,e)
	local sg1=Duel.GetMatchingGroup(c100730073.filter2,tp,LOCATION_EXTRA,0,nil,e,tp,mg1,nil,chkf)
	local mg2=nil
	local sg2=nil
	local ce=Duel.GetChainMaterial(tp)
	if ce~=nil then
		local fgroup=ce:GetTarget()
		mg2=fgroup(ce,e,tp)
		local mf=ce:GetValue()
		sg2=Duel.GetMatchingGroup(c100730073.filter2,tp,LOCATION_EXTRA,0,nil,e,tp,mg2,mf,chkf)
	end
	if sg1:GetCount()>0 or (sg2~=nil and sg2:GetCount()>0) then
		local sg=sg1:Clone()
		if sg2 then sg:Merge(sg2) end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local tg=sg:Select(tp,1,1,nil)
		local tc=tg:GetFirst()
		if sg1:IsContains(tc) and (sg2==nil or not sg2:IsContains(tc) or not Duel.SelectYesNo(tp,ce:GetDescription())) then
			local mat1=Duel.SelectFusionMaterial(tp,tc,mg1,nil,chkf)
			tc:SetMaterial(mat1)
			Duel.SendtoGrave(mat1,REASON_EFFECT+REASON_MATERIAL+REASON_FUSION)
			Duel.BreakEffect()
			Duel.SpecialSummon(tc,SUMMON_TYPE_FUSION,tp,tp,false,false,POS_FACEUP)
		else
			local mat2=Duel.SelectFusionMaterial(tp,tc,mg2,nil,chkf)
			local fop=ce:GetOperation()
			fop(ce,e,tp,tc,mat2)
		end
		tc:CompleteProcedure()
		if tc:GetAttack()<=2000 then
			local g1=Duel.SelectMatchingCard(tp,Card.IsSetCard,tp,LOCATION_DECK+LOCATION_GRAVE,0,0,1,nil,0x46)
			Duel.SendtoHand(g1,tp,REASON_RULE)
		end
		if tc:GetDefense()<=2000 then
			local g2=Duel.SelectMatchingCard(tp,Card.IsType,tp,LOCATION_DECK+LOCATION_GRAVE,0,0,1,nil,TYPE_NORMAL)
			Duel.SendtoHand(g2,tp,REASON_RULE)
		end
	end
end
function c100730073.filter1(c,e)
	return not c:IsImmuneToEffect(e)
end
function c100730073.filter2(c,e,tp,m,f,chkf)
	return c:IsType(TYPE_FUSION) and (not f or f(c)) and not c:IsType(TYPE_EFFECT)
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_FUSION,tp,false,false) and c:CheckFusionMaterial(m,nil,chkf)
end