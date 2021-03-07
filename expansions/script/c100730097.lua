--高速决斗技能-丧悼之假面
Duel.LoadScript("speed_duel_common.lua")
function c100730097.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730097.skill,c100730097.con,aux.Stringid(100730097,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730097.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_HAND,0,2,nil,13676474,86569121)
end
function c100730097.skill(e,tp,c)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730097)
	local g=Duel.GetMatchingGroup(Card.IsCode,tp,LOCATION_HAND,0,2,nil,13676474,86569121)
	local c=g:Select(tp,2,2,nil)
	if c then
		Duel.SendtoDeck(c,nil,2,REASON_RULE)
		local d=Duel.CreateToken(tp,48948935)
		Duel.MoveToField(d,tp,tp,LOCATION_MZONE,POS_FACEUP,true)
	end
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetReset(RESET_PHASE+PHASE_END,count)
	e1:SetTargetRange(1,0)
	Duel.RegisterEffect(e1,tp,true)
end
