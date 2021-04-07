--高速决斗技能-救世之光
Duel.LoadScript("speed_duel_common.lua")
function c100730202.initial_effect(c)
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PREDRAW)
	e1:SetOperation(c100730202.skill2)
	e1:SetLabelObject(c)
	Duel.RegisterEffect(e1,0)
	aux.SpeedDuelAtMainPhase(c,c100730202.skill,c100730202.con,aux.Stringid(100730202,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730202.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.GetMZoneCount(tp)>0
		and Duel.IsPlayerCanSpecialSummon(tp)
		and Duel.IsExistingMatchingCard(Card.IsType,tp,LOCATION_HAND,0,1,nil,TYPE_TUNER)
end
function c100730202.skill(e,tp,c)
	tp=e:GetLabelObject():GetOwner()
	local g=Duel.GetMatchingGroup(Card.IsType,tp,LOCATION_HAND,0,nil,TYPE_TUNER)
	local c=g:Select(tp,1,1,nil)
	if c then
		Duel.Hint(HINT_CARD,1-tp,100730202)
		Duel.SendtoDeck(c,nil,2,REASON_RULE)
		local d=Duel.CreateToken(tp,21159309)
		Duel.SpecialSummon(d,0,tp,tp,true,true,POS_FACEUP)
	end
end
function c100730202.skill2(e,tp,eg,ep,ev,re,r,rp)
	tp = e:GetLabelObject():GetOwner()
	local g=Group.CreateGroup()
	local c=Duel.CreateToken(tp,68543408)
	g:AddCard(c)
	aux.CardAddedBySkill:AddCard(c)
	c=Duel.CreateToken(tp,80244114)
	g:AddCard(c)
	aux.CardAddedBySkill:AddCard(c)
	Duel.SendtoGrave(g,REASON_RULE)
	e:Reset()
end