--高速决斗技能-幻影的野兽
Duel.LoadScript("speed_duel_common.lua")
function c100730103.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730103.skill,c100730103.con,aux.Stringid(100730103,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730103.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsPlayerCanSpecialSummon(tp)
		and Duel.GetMZoneCount(tp)>1
		and Duel.IsExistingMatchingCard(Card.IsAbleToGrave,tp,LOCATION_HAND,0,1,nil)
end
function c100730103.skill(e,tp,c)
	tp=e:GetLabelObject():GetOwner()
	local g=Duel.GetMatchingGroup(Card.IsAbleToGrave,tp,LOCATION_HAND,0,nil)
	local c=g:Select(tp,1,1,nil)
	if not c then return end
	Duel.SendtoGrave(c,nil,REASON_RULE)
	Duel.Hint(HINT_CARD,1-tp,100730103)
	local d=Duel.CreateToken(tp,4796100)
	local d1=Duel.CreateToken(tp,5818798)
	local d2=Duel.CreateToken(tp,77207191)
	Duel.SpecialSummon(d1,0,tp,tp,true,true,POS_FACEUP)
	Duel.SpecialSummon(d2,0,tp,tp,true,true,POS_FACEDOWN_DEFENSE)
	Duel.SendtoDeck(d,tp,0,REASON_RULE)
	local chkf=tp
	local mg1=Duel.GetFusionMaterial(tp):Filter(c100730103.filter1,nil,e)
	local sg1=Duel.GetMatchingGroup(c100730103.filter2,tp,LOCATION_EXTRA,0,nil,e,tp,mg1,nil,chkf)
	local mg2=nil
	local sg2=nil
	local ce=Duel.GetChainMaterial(tp)
	if ce~=nil then
		local fgroup=ce:GetTarget()
		mg2=fgroup(ce,e,tp)
		local mf=ce:GetValue()
		sg2=Duel.GetMatchingGroup(c100730103.filter2,tp,LOCATION_EXTRA,0,nil,e,tp,mg2,mf,chkf)
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
		local g1=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_DECK+LOCATION_GRAVE,0,0,3,nil,46009906,76539047)
		if g1:GetCount()>=1 then
			Duel.SendtoHand(g1,tp,REASON_RULE)
		end
		e:Reset()
	end
end

function c100730103.filter1(c,e)
	return not c:IsImmuneToEffect(e)
end
function c100730103.filter2(c,e,tp,m,f,chkf)
	return c:IsType(TYPE_FUSION) and c:IsCode(4796100) and (not f or f(c))
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_FUSION,tp,false,false) and c:CheckFusionMaterial(m,nil,chkf)
end