--高速决斗技能-等级提升
Duel.LoadScript("speed_duel_common.lua")
function c100730032.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730032.skill,c100730032.con,aux.Stringid(100730032,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730032.filter(c)
	return c:IsType(TYPE_MONSTER) and c:IsLevelAbove(1)
end
function c100730032.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(c100730032.filter,tp,LOCATION_HAND,0,1,nil)
		and Duel.IsExistingMatchingCard(c100730032.filter,tp,LOCATION_MZONE,0,1,nil)
end

function c100730032.skill(e,tp)
	Duel.Hint(HINT_MESSAGE,tp,aux.Stringid(100730032,0))
	Duel.Hint(HINT_MESSAGE,1-tp,aux.Stringid(100730032,0))
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(100730032,1))
	local source=Duel.SelectMatchingCard(tp,c100730032.filter,tp,LOCATION_HAND,0,1,1,nil):GetFirst()
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(100730032,2))
	local to=Duel.SelectMatchingCard(tp,c100730032.filter,tp,LOCATION_MZONE,0,1,1,nil):GetFirst()
	local e1=Effect.CreateEffect(to)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_LEVEL)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	e1:SetValue(source:GetLevel())
	to:RegisterEffect(e1)
	e:Reset()
end