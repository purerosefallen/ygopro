--高速决斗技能-再次并肩作战
Duel.LoadScript("speed_duel_common.lua")
function c100730178.initial_effect(c)
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PREDRAW)
	e1:SetOperation(c100730178.skill2)
	e1:SetLabelObject(c)
	Duel.RegisterEffect(e1,0)
	aux.SpeedDuelAtMainPhase(c,c100730178.skill,c100730178.con,aux.Stringid(100730178,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730178.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsPlayerCanSpecialSummon(tp)
		and Duel.IsExistingMatchingCard(c100730178.IsYU,tp,LOCATION_GRAVE,0,1,nil)
		and Duel.GetMZoneCount(tp)>0
end
function c100730178.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	local g=Duel.SelectMatchingCard(tp,c100730178.IsYU,tp,LOCATION_GRAVE,0,1,1,nil)
	if not g then return end
	local tc=g:GetFirst()
	Duel.Remove(tc,POS_FACEUP,REASON_COST)
	local g=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_DECK+LOCATION_GRAVE+LOCATION_REMOVED+LOCATION_HAND,0,1,1,nil,89943723)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,true,true,POS_FACEUP)
		else Duel.Hint(HINT_MESSAGE,tp,aux.Stringid(100730178,0))
	end
end

function c100730178.skill2(e,tp,eg,ep,ev,re,r,rp)
	tp = e:GetLabelObject():GetOwner()
	local c=Duel.CreateToken(tp,89252153)
	Duel.SendtoGrave(c,REASON_RULE)
	e:Reset()
end