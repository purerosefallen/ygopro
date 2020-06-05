--高速决斗技能-封印墓穴
Duel.LoadScript("speed_duel_common.lua")
function c100730058.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730058.skill,c100730058.con,aux.Stringid(100730058,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730058.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.GetLP(tp)+1000<=Duel.GetLP(1-tp)
end

function c100730058.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730058)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetTargetRange(1,1)
	e1:SetTarget(c100730058.limit)
	e1:SetReset(RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
	Duel.RegisterEffect(e1,tp)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_CANNOT_REMOVE)
	Duel.RegisterEffect(e2,tp)
	e:Reset()
end

function c100730058.limit(e,c,sump,sumtype,sumpos,targetp,se)
	return c:IsLocation(LOCATION_GRAVE)
end
