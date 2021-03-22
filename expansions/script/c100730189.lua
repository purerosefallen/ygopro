--高速决斗技能-妖精加油
Duel.LoadScript("speed_duel_common.lua")
function c100730189.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730189.skill,c100730189.con,aux.Stringid(100730189,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730189.Isfairy(c)
	return c:IsCode(45939611) and c:IsFaceup()
end

function c100730189.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(c100730189.Isfairy,tp,LOCATION_MZONE,0,1,nil)
		and Duel.GetLP(tp)<=6000
end
 
function c100730189.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730189)
	local g1=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_MZONE,0,1,1,nil,45939611)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
	local tc1=g1:GetFirst()
	local g2=Duel.SelectMatchingCard(tp,c100730189.filter,tp,LOCATION_EXTRA,0,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tc2=g2:GetFirst()
	if tc2 then
		Duel.BreakEffect()
		tc2:SetMaterial(g1)
		Duel.Overlay(tc2,g1)
		Duel.SpecialSummon(tc2,SUMMON_TYPE_XYZ,tp,tp,false,false,POS_FACEUP)
		tc2:CompleteProcedure()
		local g3=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_DECK+LOCATION_GRAVE+LOCATION_HAND,0,0,3,nil,12398280)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
		if ft<g3:GetCount() or not g3 then return end
		local sc=g3:GetFirst()
		while sc do
		   Duel.SpecialSummon(sc,0,tp,tp,true,true,POS_FACEUP_DEFENSE)
		   sc=g3:GetNext()
		end
		local e1=Effect.GlobalEffect()
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
		e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
		e1:SetReset(RESET_PHASE+PHASE_END)
		e1:SetTargetRange(1,0)
		Duel.RegisterEffect(e1,tp,true)
		e1:SetOwnerPlayer(tp)
	e:Reset()
	end
end
function c100730189.filter(c,tp)
	return c:IsCode(51960178) or c:IsCode(23454876)
end